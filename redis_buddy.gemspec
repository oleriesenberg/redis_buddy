# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redis_buddy/version"

Gem::Specification.new do |s|
  s.name        = "redis_buddy"
  s.version     = RedisBuddy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ole Riesenberg"]
  s.email       = ["or@buddybrand.com"]
  s.homepage    = "http://rubygems.org/gems/redis_buddy"
  s.summary     = %q{A namespaced Redis Cache Store for Rails 3}
  s.description = %q{A namespaced Redis Cache Store for Rails 3}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  Gem::Specification.new do |s|  
    s.add_dependency(%q<redis>, ["~> 2.1.1"])
    s.add_dependency(%q<redis-namespace>, [">= 0.10.0"])
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
  end
end
