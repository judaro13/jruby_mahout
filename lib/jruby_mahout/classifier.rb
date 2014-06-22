module JrubyMahout
  class Classifier

    def initialize(classifier, options={})
      @builder        = ClassifierBuilder.new(classifier, options)
      @classifier     = nil
      @data_processor = nil
      @options        = options
    end

    def train(file, options={})
      @classifier     = @builder.build_classifier
      @data_processor = JrubyMahout::ClassifierDataProcessor.new(options[:test_set_ratio])
      @data_processor.process(file, options)
      cross_validation(options)
    end

    def classify(input)
      @classifier.classifyFull(input).each_with_index.max[1]
    end

    private

    def cross_validation(options)
      accuracy         = options[:accuracy]             || 0.95
      max_tries        = options[:max_tries].to_i       || 200
      train_iterations = options[:train_iteration].to_i || 30
      (1..max_tries).each do
        target_set = single_train
        break if get_accuracy(target_set) > accuracy
      end
    end

    def single_train
      @data_processor.shuffle!
      train_set  = @data_processor.get_train_set
      target_set = @data_processor.get_targets
      train_set.each_with_index do |train, idx|
        @classifier.train(target_set[idx], train)
      end
      target_set
    end

    def get_accuracy(target_set)
      test_set      = @data_processor.get_test_set
      correct_count = 0
      test_set.each_with_index do |test, idx|
        correct_count += 1 if classify(test) == target_set[idx]
      end
      correct_count.to_f / [test_set.count, 1].max
    end

  end
end