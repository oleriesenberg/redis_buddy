module ActiveSupport
  module Cache
    class RedisBuddyStore < Store
      def initialize(*adresses)
        ns = Rails.application.class.to_s.split('::').first.downcase
        @r = RedisFactory.create(adresses)
        @data = Redis::Namespace.new(ns, :redis => @r)
      end

      def write(key, value, options = nil)
        super do
          method = options && options[:unless_exist] ? :set_unless_exists : :set

	  if options && options[:expire]
	    if info['redis_version'] <= '1.2.6'
              method = :set
              options = options[:expire]
	    else
              @data.send(:setex, options[:expire], value)
	    end
	  end
	  @data.send(method, key, value, options) if options.is_a?(Integer) || !options || (options && !options[:expire])
        end
      end

      def read(key, options = nil)
        super do
          @data.get key
        end
      end

      def ttl(key, options = nil)
        @data.ttl key, options
      end

      def delete(key, options = nil)
        super do
          @data.del key
        end
      end

      def exist?(key, options = nil)
        super do
          @data.exists key
        end
      end

      def increment(key, amount = 1)
        @data.incr key, amount
      end

      def decrement(key, amount = 1)
        @data.decr key, amount
      end

      def delete_matched(matcher, options = nil)
        super do
          @data.keys(matcher).each { |key| @data.delete key }
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

