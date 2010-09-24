class DistributedJsonRedis < Redis::Distributed

  # backwards compat
  def self.inherited(child)
    ActiveSupport::Deprecation.warn("#{child.to_s} is deprecated. Use DistributedJsonRedis instead.") if defined?(ActiveSupport::Deprecation)
  end

  def initialize(addresses)
    nodes = addresses.map do |address|
      JsonRedis.new(address)
    end
    @ring = Redis::HashRing.new(nodes)
  end
end
