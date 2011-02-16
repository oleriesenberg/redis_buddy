# a namespaced Redis Cache Store for Rails 3

## Installation

    gem install redis_buddy


## Configuration

### Gemfile

    gem "redis_buddy"

### config/application.rb

    config.cache_store = RedisBuddy::CacheStore.new('127.0.0.1')

    or

    config.cache_store = RedisBuddy::CacheStore.new(['127.0.0.1', '10.20.1.40'])


## Copyright

(c) 2011 Ole Riesenberg, released under the MIT license
