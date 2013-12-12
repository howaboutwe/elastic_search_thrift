## Elastic Search Thrift

Ruby ElasticSearch client that uses the thrift transport.

## Install

    gem install elastic_search_thrift

You will of course also need the
[thrift transport plugin for ElasticSearch][plugin].

[plugin]: https://github.com/elasticsearch/elasticsearch-transport-thrift

## Usage

    require 'elastic_search_thrift'

    # This is the default configuration.
    ElasticSearchThrift.configure(host: '127.0.0.1', port: 9500)

    ElasticSearchThrift.client.open do |client|
      client.get('/')
    end

## Tire Integration

    ElasticSearchThrift.configure_tire

## Contributing

 * [Bug reports](https://github.com/howaboutwe/elastic_search_thrift/issues)
 * [Source](https://github.com/howaboutwe/elastic_search_thrift)
 * Patches: Fork on Github, send pull request.
   * Include tests where practical.
   * Leave the version alone, or bump it in a separate commit.

## Copyright

Copyright (c) George Ogata. See LICENSE for details.
