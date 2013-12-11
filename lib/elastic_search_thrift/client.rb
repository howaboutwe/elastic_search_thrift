require 'json'

require 'elastic_search_thrift/mini_thrift'
require 'elastic_search_thrift/elasticsearch_constants'
require 'elastic_search_thrift/elasticsearch_types'
require 'elastic_search_thrift/rest'

module ElasticSearchThrift
  class Client
    def initialize(options = {})
      host = options[:host] || options['host'] || '127.0.0.1'
      port = options[:port] || options['port'] || 9500
      @socket = Thrift::Socket.new(host, port)
      @transport = Thrift::BufferedTransport.new(socket)
      @protocol = Thrift::BinaryProtocol.new(transport)
      @client = ElasticSearchThrift::Rest::Client.new(protocol)

      # Create finalizer proc in separate scope so it doesn't prevent GC.
      ObjectSpace.define_finalizer(self, self.class.finalizer_for(self))
    end

    def self.finalizer_for(instance)
      -> { instance.close }
    end

    attr_reader :socket, :transport, :protocol, :client

    def get(path, parameters = {}, body = {})
      request(ElasticSearchThrift::Method::GET, path, parameters, body)
    end

    def put(path, parameters = {}, body = {})
      request(ElasticSearchThrift::Method::PUT, path, parameters, body)
    end

    def post(path, parameters = {}, body = {})
      request(ElasticSearchThrift::Method::POST, path, parameters, body)
    end

    def delete(path, parameters = {}, body = {})
      request(ElasticSearchThrift::Method::DELETE, path, parameters, body)
    end

    def request(method, uri, parameters = {}, body = {})
      request = RestRequest.new
      request.method = method
      request.uri = uri
      request.parameters = parameters
      request.headers = {}
      request.body = body.to_json
      response = @client.execute(request)
      JSON.parse(response.body)
    end

    def open
      @transport.open unless open?
      if block_given?
        begin
          yield
        ensure
          close
        end
      end
    end

    def open?
      @transport.open?
    end

    def close
      @transport.close if open?
    end
  end
end
