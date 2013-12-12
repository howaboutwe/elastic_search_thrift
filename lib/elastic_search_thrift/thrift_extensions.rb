module ElasticSearchThrift
  module ResponseMixin
    def data
      @data ||= JSON.parse(body)
    end
  end

  RestResponse.send :include, ResponseMixin
end
