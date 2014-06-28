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

    def set(key, value, option={})
      @redis.set(key, value)
      @redis.expire(key, option[:expire_in]) if option[:expire_in]
    end
  end
end