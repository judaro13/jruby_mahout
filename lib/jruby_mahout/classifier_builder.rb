module JrubyMahout
  class ClassifierBuilder

    java_import org.apache.mahout.classifier.sgd.L1
    java_import org.apache.mahout.classifier.sgd.OnlineLogisticRegression

    attr_accessor :classifier

    def initialize(algorithm, options)
      @algorithm = algorithm
      @options   = options
    end

    def build_classifier
      if @algorithm == 'OnlineLogisticRegression'
        alpha           = @options[:alpha] || 1
        step_offset     = @options[:step_offset] || 1000
        decay_exponent  = @options[:decay_exponent] || 0.9
        lambda          = @options[:lambda] || 3.0e-5
        learning_rate   = @options[:learning_rate] || 20
        num_categories  = @options[:num_categories]
        num_of_features = @options[:num_of_features]
                                                  # numCategories, int numFeatures, PriorFunction prior
        @classifier = OnlineLogisticRegression.new(num_categories, num_of_features, L1.new)
                                              .alpha(alpha)
                                              .stepOffset(step_offset)
                                              .decayExponent(decay_exponent)
                                              .lambda(lambda)
                                              .learningRate(learning_rate)
      end

      @classifier
    end

  end
end