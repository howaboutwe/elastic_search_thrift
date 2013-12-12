ROOT = File.expand_path('..', File.dirname(__FILE__))
$:.unshift "#{ROOT}/lib"

require 'minitest/spec'
require 'yaml'
require 'net/http'
require 'elastic_search_thrift'

require RUBY_VERSION < '2' ? 'debugger' : 'byebug'

CONFIG = YAML.load_file("#{ROOT}/test/config.yml")
INDEX = CONFIG.delete('index') || 'elastic_search_thrift'
ElasticSearchThrift.configure(CONFIG)

MiniTest::Spec.class_eval do
  def with_thrift_client(&block)
    client = ElasticSearchThrift::Client.new(host: CONFIG['host'], port: CONFIG['thrift_port'])
    client.open(&block)
  end

  def with_http_client
    http = Net::HTTP.new(CONFIG['host'], CONFIG['http_port'])
    http.start do
      begin
        yield http
      ensure
        http.delete("/#{INDEX}")
      end
    end
  end
end
