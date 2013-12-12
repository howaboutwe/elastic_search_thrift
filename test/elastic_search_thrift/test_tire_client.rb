require_relative '../test_helper'

ElasticSearchThrift::TireClient.install

describe ElasticSearchThrift::TireClient do
  let(:client) { ElasticSearchThrift::TireClient.new }

  def parse(json)
    JSON.parse(json)
  end

  it "executes requests and returns the response" do
    response = client.get('/', {})
    parse(response.body)['status'].must_equal 200
    parse(response.body)['version'].wont_be_nil
  end

  it "performs GET, POST, PUT, and DELETE requests properly" do
    base_url = "http://#{CONFIG['host']}:#{CONFIG['port']}"
    with_http_client do |http|
      client.put("#{base_url}/#{INDEX}", {})
      status = JSON.parse(http.get("/#{INDEX}/_status").body)
      status['indices'].keys.must_include INDEX

      client.post("#{base_url}/#{INDEX}/thing?refresh=true", {name: 'a'})
      response = client.get("#{base_url}/#{INDEX}/thing/_search")
      parse(response.body)['hits']['total'].must_equal 1

      id = parse(response.body)['hits']['hits'][0]['_id']
      client.delete("#{base_url}/#{INDEX}/thing/#{id}?refresh=true")
      response = client.get("#{base_url}/#{INDEX}/thing/_search")
      parse(response.body)['hits']['total'].must_equal 0
    end
  end

  it "integrates correctly into the Tire DSL" do
    with_http_client do |http|
      index = Tire::Index.new(INDEX)
      index.create.success?.must_equal true
      status = JSON.parse(http.get("/#{INDEX}/_status").body)
      status['indices'].keys.must_include INDEX

      index.store(_type: 'thing', name: 'a')
      index.refresh
      response = client.get("/#{INDEX}/thing/_search")
      parse(response.body)['hits']['total'].must_equal 1

      id = parse(response.body)['hits']['hits'][0]['_id']
      index.remove(_type: 'thing', id: id)
      index.refresh

      response = client.get("/#{INDEX}/thing/_search")
      parse(response.body)['hits']['total'].must_equal 0
    end
  end
end
