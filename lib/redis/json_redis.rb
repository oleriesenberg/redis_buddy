class JsonRedis < Redis

  # backwards compat
  def self.inherited(child)
    ActiveSupport::Deprecation.warn("#{child.to_s} is deprecated. Use JsonRedis instead.") if defined?(ActiveSupport::Deprecation)
  end

  def set(key, value)
    value = Yajl.dump(value) if encode?(value)
    super(key, value)
  end

  def setex(key, value, expires)
    value = Yajl.dump(value) if encode?(value)
    super(key, value, expires)
  end

  def get(key)
    result = @client.call(:get, key)
    result = Yajl.load(result) if result
    result
  end

  private
  def encode?(value)
    !value.is_a?(Integer)
  end
end

