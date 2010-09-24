module ActiveSupport
  module Cache
    class RedisBuddyStore < Store
      def initialize(*adresses)
        ns = Rails.application.class.to_s.split('::').first.downcase
        @r = RedisFactory.create(adresses)
        @data = Redis::Namespace.new(ns, :redis => @r)
      end

      def write(key, value, options = nil)
        method = options && options[:unless_exist] ? :set_unless_exists : :set

        if options && options[:expire]
          if (info.is_a?(Array) ? info.first['redis_version'] : info['redis_version']) <= '1.2.6'
            @data.send(:set, key, value)
            @data.send(:expire, key, options[:expire])
          else
            @data.send(:setex, key, value,options[:expire])
          end
        else
          @data.send(method, key, value)
        end
      end

      def read(key)
        @data.get(key)
      end

      def ttl(key)
        @data.ttl(key)
      end

      def delete(key)
        @data.del(key)
      end

      def exist?(key)
        @data.exists(key)
      end

      def increment(key, amount = nil)
        amount.nil? ? @data.incr(key) : @data.incrby(key, amount)
      end

      def decrement(key, amount = nil)
        amount.nil? ? @data.decr(key) : @data.decrby(key, amount)
      end

      def delete_matched(matcher)
        super do
          @data.keys(matcher).each { |key| @data.del(key) }
        end
      end

      def clear
        @data.flushdb
      end

      def info
        @data.info
      end
    end
  end
end

