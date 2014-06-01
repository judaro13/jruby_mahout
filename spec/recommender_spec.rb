require 'spec_helper'

describe JrubyMahout::Recommender do
  describe ".new" do
    context "with valid arguments" do
      it "should return an instance of JrubyMahout::Recommender for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for GenericItemSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "GenericItemSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

      it "should return an instance of JrubyMahout::Recommender for GenericItemSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "GenericItemSimilarity", :recommender => "GenericItemBasedRecommender"}
        JrubyMahout::Recommender.new(params).should
        be_an_instance_of JrubyMahout::Recommender
      end

    end
  end

  describe "data_model=" do
    it "should load file data model" do
      params      = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
      recommender = JrubyMahout::Recommender.new(params)
      recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

      recommender.data_model.should be_an_instance_of org.apache.mahout.cf.taste.impl.model.file.FileDataModel
    end
  end

  describe "SVDRecommender" do
    it "should return an array for SVDRecommender" do
      params      = {:similarity => "ALSWRFactorizer", :recommender => "SVDRecommender", :num_of_features => 1}
      recommender = JrubyMahout::Recommender.new(params)
      recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

      recommender.recommend(1, 10, nil).should be_an_instance_of Array
    end
  end

  describe ".recommend" do
    context "with valid arguments" do
      context "with NearestNUserNeighborhood" do
        it "should return an array for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for GenericItemSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "GenericItemSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
  
        it "should return an array for GenericItemSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "GenericItemSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model
  
          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
      end

      context "with ThresholdUserNeighborhood" do
        it "should return an array for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for GenericItemSimilarity and GenericUserBasedRecommender" do
          params      = {:similarity => "GenericItemSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 0.7}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end

        it "should return an array for GenericItemSimilarity and GenericItemBasedRecommender" do
          params      = {:similarity => "GenericItemSimilarity", :recommender => "GenericItemBasedRecommender"}
          recommender = JrubyMahout::Recommender.new(params)
          recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

          recommender.recommend(1, 10, nil).should be_an_instance_of Array
        end
      end
    end

    context "with invalid arguments" do
      it "should return nil for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommend(1, 10, nil).should == []
      end
    end
  end

  describe ".evaluate" do
    context "with valid arguments" do
      it "should return a float" do
        params = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return an array for PearsonCorrelationSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for EuclideanDistanceSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for SpearmanCorrelationSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for LogLikelihoodSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for TanimotoCoefficientSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for GenericItemSimilarity and GenericUserBasedRecommender" do
        params = {:similarity => "GenericItemSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for PearsonCorrelationSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for EuclideanDistanceSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "EuclideanDistanceSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for LogLikelihoodSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "LogLikelihoodSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for TanimotoCoefficientSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "TanimotoCoefficientSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end

      it "should return a float for GenericItemSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "GenericItemSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be_an_instance_of Float
      end
    end

    context "with invalid arguments" do
      it "should return nil for SpearmanCorrelationSimilarity and GenericItemBasedRecommender" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.evaluate(0.7, 0.3).should be nil
      end
    end
  end

  # TODO: cover all cases
  describe ".similar_users" do
    context "with valid arguments" do
      it "should return an array of users" do
        params = {:similarity => "SpearmanCorrelationSimilarity", :recommender => "GenericUserBasedRecommender", :neighborhood_size => 5}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.similar_users(1, 10, nil).should be_an_instance_of Array
      end
    end
  end

  # TODO: cover all cases
  describe ".similar_items" do
    context "with valid arguments" do
      it "should return an array of items" do
        params = {:similarity => "GenericItemSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.similar_items(4, 10, nil).should be_an_instance_of Array
      end
    end
  end

  # TODO: cover all cases
  describe ".recommended_because" do
    context "with valid arguments" do
      it "should return an array of items" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.recommended_because(1, 138, 5).should be_an_instance_of Array
      end
    end
  end

  # TODO: cover all cases
  describe ".estimate_preference" do
    context "with valid arguments" do
      it "should return afloat with an estimate" do
        params = {:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender"}
        recommender = JrubyMahout::Recommender.new(params)
        recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model

        recommender.estimate_preference(1, 138).should be_an_instance_of Float
      end
    end
  end
end