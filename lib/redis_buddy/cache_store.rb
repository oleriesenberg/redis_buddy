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
          returning @data.send(method, key, value, options) do 
            @data.expire key, options[:expire] if options && options[:expire]
	  end
        end
      end

      def read(key, options = nil)
        super do
          @data.get key, options
        end
      end

      def ttl(key, options = nil)
        @data.ttl key, options
      end

      def delete(key, options = nil)
        super do
          @data.delete key
        end
      end

      def exist?(key, options = nil)
        super do
          @data.key? key
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
        @data.flush_db
      end

      def info
        @data.info
      end
    end
  end
end

