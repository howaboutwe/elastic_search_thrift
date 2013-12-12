require 'tire'
require 'cgi'
require 'uri'

module ElasticSearchThrift
  class TireClient
    def self.install
      Tire::Configuration.client(new)
    end

    def initialize
      @client = ElasticSearchThrift.client
      @client.open
    end

    attr_reader :client

    def get(url, data = {})
      execute :get, url, data
    end

    def post(url, data)
      execute :post, url, data
    end

    def put(url, data)
      execute :put, url, data
    end

    def delete(url)
      execute :delete, url, nil
    end

    def head(url)
      execute :head, url, nil
    end

    private

    def execute(method, url, data)
      path, params = parse_url(url)
      path.chomp!('/')
      response = client.send(method, path, params, normalize_data(data))
      Tire::HTTP::Response.new(response.body, response.status, response.headers)
    end

    def parse_url(url)
      uri = URI.parse(url)

      params = {}
      if uri.query
        uri.query.split('&').each do |pair|
          key, value = pair.split('=', 2)
          params[CGI.unescape(key)] = CGI.unescape(value)
        end
      end

      [uri.path, params]
    end

    def normalize_data(data)
      if data.is_a?(String)
        data =~ /\S/ ? JSON.parse(data) : {}
      else
        data || {}
      end
    end
  end
end
