require 'rubygems'
require 'rake'
require 'rake/testtask'

desc 'Default: run tests.'
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "redis_buddy"
    s.summary = "A namespaced Redis Cache Store for Rails 3"
    s.email = "labs@buddybrand.de"
    s.homepage = "http://buddybrand.de"
    s.description = "A namespaced Redis Cache Store for Rails 3, based on redis-store"
    s.authors = ["Ole Riesenberg"]
    s.files = FileList["{lib,test}/**/*.rb"]
    s.add_dependency "redis", "~> 2.0.6"
    s.add_dependency "redis-namespace", ">= 0.8.0"
    s.add_dependency "yajl-ruby"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
