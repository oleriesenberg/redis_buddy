# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{redis_buddy}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ole Riesenberg"]
  s.date = %q{2010-03-26}
  s.description = %q{redis namespaced cache store for rails 3, based on redis-store}
  s.email = %q{labs@buddybrand.de}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "lib/redis/distributed_marshaled_redis.rb",
     "lib/redis/marshaled_redis.rb",
     "lib/redis/redis_factory.rb",
     "lib/redis_buddy.rb",
     "lib/redis_buddy/cache_store.rb"
  ]
  s.homepage = %q{http://buddybrand.de}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{a namespaced Redis Cache Store for Rails 3}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/redis/distributed_marshaled_redis_spec.rb",
     "spec/redis/marshaled_redis_spec.rb",
     "spec/redis/redis_factory_spec.rb",
     "spec/cache/redis_buddy_store.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 0.2.0"])
      s.add_runtime_dependency(%q<redis-namespace>, [">= 0.3.0"])
    else
      s.add_dependency(%q<redis>, [">= 0.2.0"])
      s.add_dependency(%q<redis-namespace>, [">= 0.3.0"])
    end
  else
    s.add_dependency(%q<redis>, [">= 0.2.0"])
    s.add_dependency(%q<redis-namespace>, [">= 0.3.0"])
  end
end

