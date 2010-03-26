require 'rubygems'
require 'rake'
require 'rake/testtask'

desc 'Default: run tests.'
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "redis_buddy"
    s.summary = "a namespaced Redis Cache Store for Rails 3"
    s.email = "labs@buddybrand.de"
    s.homepage = "http://buddybrand.de"
    s.description = "redis namespaced cache store for rails 3, based on redis-store"
    s.authors = ["Ole Riesenberg"]
    s.files = FileList["{lib,test}/**/*.rb"]
    s.add_dependency "redis", ">= 0.2.0"
    s.add_dependency "redis-namespace", ">= 0.3.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
