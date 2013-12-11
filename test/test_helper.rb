ROOT = File.expand_path('..', File.dirname(__FILE__))
$:.unshift "#{ROOT}/lib"

require 'minitest/spec'
require 'yaml'
require 'elastic_search_thrift'

require RUBY_VERSION < '2' ? 'debugger' : 'byebug'

CONFIG = YAML.load_file("#{ROOT}/test/config.yml")

MiniTest::Spec.class_eval do
  def make_client
    ElasticSearchThrift::Client.new(host: CONFIG['host'], port: CONFIG['port'])
  end
end
