module JrubyMahout
  class RedisCache
    attr_accessor :on, :redis, :prefix

    class NilRedis
      def get(*args); end
      def set(*args); end
    end

    def initialize(url, prefix)
      @redis  = url ? Redis.new(:url => url) : NilRedis.new
      @prefix = prefix
    end

    def empty!(key)
      @redis.del(key)
    end

    def get(key)
      val = @redis.get(key)
      JSON.parse val if val
    end

    def set(key, value)
      @redis.set(key, value)
    end
  end
end