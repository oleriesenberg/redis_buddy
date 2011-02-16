module ActiveSupport
  module Cache
    class RedisBuddyStore < Store
      def initialize(*adresses)
        ns = Rails.application.class.to_s.split('::').first.downcase
        @r = RedisFactory.create(adresses)
        @client = Redis::Namespace.new(ns, :redis => @r)
      end

      def write(key, value, options = {})
        method = :getset if options[:return]
        method = :setnx if options[:nx]
        method, ttl = :setex, options[:ttl] if options[:ttl]
        method = :set unless method
        value = encode(value)

        ttl ? @client.send(method, key, ttl, value) : @client.send(method, key, value)
      end

      def push(key, value)
        @client.lpush(key, encode(value))
      end

      def increment(key, amount = nil)
        amount.nil? ? @client.incr(key) : @client.incrby(key, amount)
      end

      def decrement(key, amount = nil)
        amount.nil? ? @client.decr(key) : @client.decrby(key, amount)
      end

      def expire_in(key, ttl)
        @client.expire(key, ttl)
      end

      def exipire_at(key, time)
        @client.exipireat(key, time)
      end

      def read(key)
        value = @client.get(key)
        value ? decode(value) : nil
      end

      def pop(key)
        value = @client.rpop(key)
        value ? decode(value) : nil
      end

      def length(key)
        @client.llen(key)
      end

      def ttl(key)
        @client.ttl(key)
      end

      def type(key)
        @client.type(key)
      end

      def exists?(key)
        @client.exists(key)
      end

      def delete(key)
        @client.del(key)
      end

      def clear
        @client.flushdb
      end

      def info
        @client.info
      end

      def keys(pattern = "*")
        @client.keys(pattern)
      end

      def client
        @client
      end

      private
      def decode(value)
        value = Yajl.load(value)
        value.with_indifferent_access if value.is_a?(Hash)
        value
      end

      def encode(value)
        return value unless encode?(value)
        Yajl.dump(value)
      end

      def encode?(value)
        !value.is_a?(Integer) 
      end
    end
  end
end

