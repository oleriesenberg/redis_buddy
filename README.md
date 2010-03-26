# a namespaced Redis Cache Store for Rails 3

## Installation

    gem install redis_buddy


## Configuration

### Gemfile

    gem "redis_buddy"

### config/application.rb

    config.cache_store = :redis_buddy_store

    or

    config.cache_store = :redis_buddy_store, ['127.0.0.1', '1.2.3.4']


## Copyright

(c) 2010 Ole Riesenberg, released under the MIT license

redis-store (c) 2009 Luca Guidi - [http://lucaguidi.com](http://lucaguidi.com), released under the MIT license
