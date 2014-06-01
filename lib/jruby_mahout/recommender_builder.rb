module JrubyMahout
  class RecommenderBuilder
    java_import org.apache.mahout.cf.taste.eval.RecommenderBuilder
    java_import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
    java_import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity
    java_import org.apache.mahout.cf.taste.impl.similarity.SpearmanCorrelationSimilarity
    java_import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity
    java_import org.apache.mahout.cf.taste.impl.similarity.TanimotoCoefficientSimilarity

    java_import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood
    java_import org.apache.mahout.cf.taste.impl.neighborhood.ThresholdUserNeighborhood

    java_import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
    java_import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender

    java_import org.apache.mahout.cf.taste.impl.recommender.svd.SVDRecommender
    java_import org.apache.mahout.cf.taste.impl.recommender.svd.ALSWRFactorizer

    java_import org.apache.mahout.cf.taste.common.Weighting

    attr_accessor :recommender_name, :item_based_allowed
    # public interface RecommenderBuilder
    # Implementations of this inner interface are simple helper classes which create a Recommender to be evaluated based on the given DataModel.
    def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted, features=0)
      @is_weighted        = is_weighted
      @neighborhood_size  = neighborhood_size
      @similarity_name    = similarity_name
      @recommender_name   = recommender_name
      @item_based_allowed = (@similarity_name == "SpearmanCorrelationSimilarity") ? false : true
      @features           = features
    end

    # buildRecommender(DataModel dataModel)
    # Builds a Recommender implementation to be evaluated, using the given DataModel.
    def build_recommender(data_model)
      begin
        similarity   = build_similarity(data_model)
        neighborhood = build_neighborhood(data_model, similarity)
        create_recommender(data_model, neighborhood, similarity)
      rescue Exception => e
        puts "#{$!}\n #{$@.join("\n")}"
      end
    end

    def build_similarity(data_model)
      case @similarity_name
        when "PearsonCorrelationSimilarity"
          @is_weighted ? PearsonCorrelationSimilarity.new(data_model, Weighting::WEIGHTED) : PearsonCorrelationSimilarity.new(data_model)
        when "EuclideanDistanceSimilarity"
          @is_weighted ? EuclideanDistanceSimilarity.new(data_model, Weighting::WEIGHTED) : EuclideanDistanceSimilarity.new(data_model)
        when "SpearmanCorrelationSimilarity"
          SpearmanCorrelationSimilarity.new(data_model)
        when "LogLikelihoodSimilarity"
          LogLikelihoodSimilarity.new(data_model)
        when "TanimotoCoefficientSimilarity"
          TanimotoCoefficientSimilarity.new(data_model)
        when "GenericItemSimilarity"
          PearsonCorrelationSimilarity.new(data_model, Weighting::WEIGHTED)
        when "ALSWRFactorizer"
          ALSWRFactorizer.new(data_model, @features, 0.065, 15);
        else
          nil
      end
    end

    def build_neighborhood(data_model, similarity)
      if !@neighborhood_size.nil? && @features == 0
        if @neighborhood_size > 1
          neighborhood = NearestNUserNeighborhood.new(Integer(@neighborhood_size), similarity, data_model)
        elsif @neighborhood_size >= -1 and @neighborhood_size <= 1
          neighborhood = ThresholdUserNeighborhood.new(Float(@neighborhood_size), similarity, data_model)
        end
      end
    end

    def create_recommender(data_model, neighborhood=nil, similarity=nil)
      case @recommender_name
        when "GenericUserBasedRecommender"
          GenericUserBasedRecommender.new(data_model, neighborhood, similarity)
        when "GenericItemBasedRecommender"
          @item_based_allowed ? GenericItemBasedRecommender.new(data_model, similarity) : JrubyMahout::NilRecommender.new
        when "SlopeOneRecommender"
          SlopeOneRecommender.new(data_model)
        when "SVDRecommender"
          SVDRecommender.new(data_model, similarity)
        else
          nil
      end
    end
  end
end