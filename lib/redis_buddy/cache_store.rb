module RedisBuddy
  class CacheStore < ActiveSupport::Cache::Store
    def initialize(*adresses)
      options = adresses.extract_options!
      ns = options.delete(:redis_namespace) || Rails.application.class.to_s.split('::').first.downcase
      @r = RedisFactory.create(adresses)
      @client = Redis::Namespace.new(ns, :redis => @r)
      super options
    end

    def push(key, value)
      @client.lpush(key, encode(value))
    end

    def pop(key)
      value = @client.rpop(key)
      value ? decode(value) : nil
    end

    def exist?(key)
      @client.exists(key)
    end
    alias :exists? :exist?

    def increment(key, amount = nil)
      amount.nil? ? @client.incr(key) : @client.incrby(key, amount)
    end

    def decrement(key, amount = nil)
      amount.nil? ? @client.decr(key) : @client.decrby(key, amount)
    end

    def delete_matched(matcher, options = nil)
      delete keys(matcher)
    end

    def expire_in(key, ttl)
      @client.expire(key, ttl)
    end

    def exipire_at(key, time)
      @client.exipireat(key, time)
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

    def clear
      @client.flushdb
    end

    def info
      @client.info
    end

    def keys(matcher = "*", options = nil)
      options = merged_options(options)
      @client.keys namespaced_key(matcher, options)
    end

    def client
      @client
    end

    protected
    def write_entry(key, entry, options = {})
      options[:expires_in] = options.delete(:ttl) if options[:ttl]
      options[:unless_exist] = options.delete(:nx) if options[:nx]
      options[:getset] = options.delete(:return) if options[:return]

      method = :getset if options[:getset]
      method = :setnx if options[:unless_exist]
      method, expires_in = :setex, options[:expires_in] if options[:expires_in]
      method = :set unless method
      entry = encode(entry)

      expires_in ? @client.send(method, key, expires_in, entry) : @client.send(method, key, entry)
    end

    def read_entry(key, options)
      entry = @client.get(key)
      entry ? decode(entry) : nil
    end

    def delete_entry(key, options)
      @client.del(key)
    end

    private
    def decode(value)
      value = Marshal.load(value)
      value.with_indifferent_access if value.is_a?(Hash)
      value
    end

    def encode(value)
      return value unless encode?(value)
      Marshal.dump(value)
    end

    def encode?(value)
      !value.is_a?(Integer) 
    end
  end
end

