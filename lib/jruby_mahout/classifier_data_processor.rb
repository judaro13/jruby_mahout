module JrubyMahout
  class ClassifierDataProcessor

    def initialize(test_set_ratio)
      @test_set_ratio = test_set_ratio
      @data           = []
      @target_column  = nil
    end

    # Default options = {
    #   :delimiter     => ","
    #   :skip_columns  => [],
    #   :target_column => nil,
    #   :skip_header   => true
    # }
    # file should be either csv or tsv or any delimiter separated file
    def process(file, options)
      delimiter      = options[:delimiter]    || ","
      @target_column = options[:target_column]
      skip_columns   = options[:skip_columns] || []
      skip_header    = options[:skip_header]  || true
      File.open(file, 'r') do |infile|
        infile.gets if skip_header
        while(line = infile.gets)
          columns = line.strip.split(options[:delimiter], -1)
          remove_column!(columns, skip_columns)
        end
      end
    end

    def shuffle!
      @data.shuffle!
    end

    def get_train_set
      test_size = @data.size * test_set_ratio
      @data[(test_size+1)..-1]
    end

    def get_test_set
      @data[0..(@data.size * @test_set_ratio)]
    end

    def get_targets
      @targets ||= begin
        @data.map {|row| row[@target_column]}
      end
    end

    private

    def remove_column!(columns, skip_columns)
      skip_columns.each do |col|
        columns.delete_at(col)
      end
    end

  end
end