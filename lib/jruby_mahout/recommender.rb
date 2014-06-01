module JrubyMahout
  class Recommender
    include JrubyMahout::Helpers::ExceptionHandler

    attr_accessor :data_model, :recommender, :redis_cache

    def initialize(params)
      @recommender_builder = RecommenderBuilder.new(params)
      @data_model  = nil
      @recommender = nil
      @redis_cache = params[:redis] ? RedisCache.new(params[:redis][:url], params[:redis][:prefix]) : nil
    end

    def data_model=(data_model)
      @data_model = data_model
      @recommender = @recommender_builder.build_recommender(@data_model)
    end

    def recommend(user_id, number_of_items, rescorer)
      with_exception do
        cached_recommendations = @redis_cache ? @redis_cache.redis.get(recommendations_key(user_id, number_of_items)) : nil

        if cached_recommendations
          JSON.parse(cached_recommendations)
        else
          recommendations = @recommender.recommend(user_id, number_of_items, rescorer)
          recommendations_array = []

          recommendations.each do |recommendation|
            recommendations_array << [recommendation.getItemID, recommendation.getValue.round(5)]
          end

          @redis_cache.redis.set(recommendations_key(user_id, number_of_items), recommendations_array.to_json) if @redis_cache

          recommendations_array
        end
      end
    end

    def evaluate(training_percentage, evaluation_percentage)
      with_exception do
        evaluator = Evaluator.new(@data_model, @recommender_builder)
        evaluator.evaluate(training_percentage, evaluation_percentage)
      end
    end

    def similar_items(item_id, number_of_items, rescorer)
      with_exception do
        cached_similar_items = @redis_cache ? @redis_cache.redis.get(similar_items_key(item_id, number_of_items)) : nil

        if cached_similar_items
          JSON.parse(cached_similar_items)
        else
          similarities = @recommender.mostSimilarItems(item_id, number_of_items, rescorer)
          similarities_array = []

          similarities.each do |similarity|
            similarities_array << similarity.getItemID
          end

          @redis_cache.redis.set(similar_items_key(item_id, number_of_items), similarities_array.to_json) if @redis_cache

          similarities_array
        end

      end
    end

    def similar_users(user_id, number_of_users, rescorer)
      with_exception do
        cached_similar_users = @redis_cache ? @redis_cache.redis.get(similar_users_key(user_id, number_of_users)) : nil

        if cached_similar_users
          JSON.parse(cached_similar_users)
        else
          similar_users = to_array(@recommender.mostSimilarUserIDs(user_id, number_of_users, rescorer))

          @redis_cache.redis.set(similar_users_key(user_id, number_of_users), similar_users.to_json) if @redis_cache

          similar_users
        end

      end
    end

    def estimate_preference(user_id, item_id)
      with_exception do
        cached_estimate_preference = @redis_cache ? @redis_cache.redis.get(estimate_preference_key(user_id, item_id, number_of_items)) : nil

        if cached_estimate_preference
          JSON.parse(cached_estimate_preference)
        else
          estimate_preference = @recommender.estimatePreference(user_id, item_id)

          @redis_cache.redis.set(estimate_preference_key(user_id, item_id, number_of_items), estimate_preference.to_json) if @redis_cache

          estimate_preference
        end

      end
    end

    def recommended_because(user_id, item_id, number_of_items)
      with_exception do
        cached_recommended_because = @redis_cache ? @redis_cache.redis.get(recommended_because_key(user_id, item_id, number_of_items)) : nil

        if cached_recommended_because
          JSON.parse(cached_recommended_because)
        else
          recommended_because = to_array(@recommender.recommendedBecause(user_id, item_id, number_of_items))

          @redis_cache.redis.set(recommended_because_key(user_id, item_id, number_of_items), recommended_because.to_json) if @redis_cache

          recommended_because
        end
      end
    end

    private

    def to_array(things)
      things_array = []
      things.each do |thing_id|
        things_array << thing_id
      end

      things_array
    end

    def recommendations_key(user_id, number_of_items)
      "#{@redis_cache.prefix}-recommendations-user_id:#{user_id}-number_of_items:#{number_of_items}"
    end

    def similar_items_key(item_id, number_of_items)
      "#{@redis_cache.prefix}-similar_items-item_id:#{item_id}-number_of_items:#{number_of_items}"
    end

    def similar_users_key(user_id, number_of_users)
      "#{@redis_cache.prefix}-similar_users-user_id:#{user_id}-number_of_users:#{number_of_users}"
    end

    def estimate_preference_key(user_id, item_id, number_of_items)
      "#{@redis_cache.prefix}-estimate_preference-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}"
    end

    def recommended_because_key(user_id, item_id, number_of_items)
      "#{@redis_cache.prefix}-recommended_because-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}"
    end

  end
end