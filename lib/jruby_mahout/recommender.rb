module JrubyMahout
  class Recommender
    include JrubyMahout::Helpers::ExceptionHandler

    attr_accessor :data_model, :recommender, :redis_cache

    def initialize(params)
      @recommender_builder = RecommenderBuilder.new(params)
      @data_model  = nil
      @recommender = nil
      @params      = params
      @redis_cache = RedisCache.new(params.hash_val(:redis, :url), params.hash_val(:redis, :prefix))
    end

    def data_model=(data_model)
      @data_model = data_model
      @recommender = @recommender_builder.build_recommender(@data_model)
    end

    def recommend(user_id, number_of_items, rescorer, option={})
      with_exception do
        cached_recommendations = @redis_cache.get(recommendations_key(user_id, number_of_items))

        cached_recommendations ||= begin
          recommendations = @recommender.recommend(user_id, number_of_items, rescorer)
          recommendations_array = []

          recommendations.each do |recommendation|
            recommendations_array << [recommendation.getItemID, recommendation.getValue.round(5)]
          end

          @redis_cache.set(recommendations_key(user_id, number_of_items), recommendations_array.to_json, option)

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

    def similar_items(item_id, number_of_items, rescorer, option={})
      with_exception do
        cached_similar_items = @redis_cache.get(similar_items_key(item_id, number_of_items))

        cached_similar_items ||= begin
          similarities = @recommender.mostSimilarItems(item_id, number_of_items, rescorer)
          similarities_array = []

          similarities.each do |similarity|
            similarities_array << similarity.getItemID
          end

          @redis_cache.set(similar_items_key(item_id, number_of_items), similarities_array.to_json, option)

          similarities_array
        end

      end
    end

    def similar_users(user_id, number_of_users, rescorer, option={})
      with_exception do
        cached_similar_users = @redis_cache.get(similar_users_key(user_id, number_of_users))

        cached_similar_users ||= begin
          similar_users = to_array(@recommender.mostSimilarUserIDs(user_id, number_of_users, rescorer))

          @redis_cache.set(similar_users_key(user_id, number_of_users), similar_users.to_json, option)

          similar_users
        end

      end
    end

    def estimate_preference(user_id, item_id, option={})
      with_exception do
        cached_estimate_preference = @redis_cache.get(estimate_preference_key(user_id, item_id))

        cached_estimate_preference ||= begin
          estimate_preference = @recommender.estimatePreference(user_id, item_id)

          @redis_cache.set(estimate_preference_key(user_id, item_id), estimate_preference.to_json, option)

          estimate_preference
        end

      end
    end

    def recommended_because(user_id, item_id, number_of_items, option={})
      with_exception do
        cached_recommended_because = @redis_cache.get(recommended_because_key(user_id, item_id, number_of_items))

        cached_recommended_because ||= begin
          recommended_because = to_array(@recommender.recommendedBecause(user_id, item_id, number_of_items))

          @redis_cache.set(recommended_because_key(user_id, item_id, number_of_items), recommended_because.to_json, option)

          recommended_because
        end
      end
    end

    def recommendations_key(user_id, number_of_items)
      "#{@redis_cache.prefix}-recommendations-user_id:#{user_id}-number_of_items:#{number_of_items}#{cache_key_suffix}"
    end

    def similar_items_key(item_id, number_of_items)
      "#{@redis_cache.prefix}-similar_items-item_id:#{item_id}-number_of_items:#{number_of_items}#{cache_key_suffix}"
    end

    def similar_users_key(user_id, number_of_users)
      "#{@redis_cache.prefix}-similar_users-user_id:#{user_id}-number_of_users:#{number_of_users}#{cache_key_suffix}"
    end

    def estimate_preference_key(user_id, item_id)
      "#{@redis_cache.prefix}-estimate_preference-user_id:#{user_id}-item_id:#{item_id}#{cache_key_suffix}"
    end

    def recommended_because_key(user_id, item_id, number_of_items)
      "#{@redis_cache.prefix}-recommended_because-user_id:#{user_id}-item_id:#{item_id}-number_of_items:#{number_of_items}#{cache_key_suffix}"
    end

    private

    def to_array(things)
      things_array = []
      things.each do |thing_id|
        things_array << thing_id
      end

      things_array
    end

    def cache_key_suffix
      "-#{@params.to_s}"
    end
  end
end