module JrubyMahout
  class RedisCache
    attr_accessor :on, :redis, :prefix

    def initialize(url, prefix)
      @redis  = Redis.new(:url => url)
      @prefix = prefix
    end

    def empty!(value, params)
      params_string = ""
      params.each do |key, val|
        params_string += "-#{key}:#{val}"
      end
      @redis.del("#{@prefix}-#{value}#{params_string}")
    end
  end
end