module ElasticSearchThrift
  autoload :Client, 'elastic_search_thrift/client'
  autoload :TireClient, 'elastic_search_thrift/tire_client'
  autoload :VERSION, 'elastic_search_thrift/version'

  class << self
    attr_accessor :configuration

    def configure(attributes)
      self.configuration = attributes
    end

    def client
      @client ||= Client.new(configuration)
    end

    def configure_tire
      TireClient.install
    end
  end
end
