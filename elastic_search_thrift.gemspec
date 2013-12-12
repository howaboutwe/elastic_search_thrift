# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('lib', File.dirname(__FILE__))
require 'elastic_search_thrift/version'

Gem::Specification.new do |gem|
  gem.name          = 'elastic_search_thrift'
  gem.version       = ElasticSearchThrift::VERSION
  gem.authors       = ['George Ogata']
  gem.email         = ['george.ogata@gmail.com']
  gem.description   = "Thrift client for ElasticSearch"
  gem.summary       = "Thrift client for ElasticSearch"
  gem.homepage      = 'https://github.com/howaboutwe/elastic_search_thrift'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency 'thrift', '~> 0.9.1'
  gem.add_dependency 'json', '>= 1.6.0', '< 1.9.0'
  gem.add_development_dependency 'bundler'
end
