require_relative '../test_helper'

describe ElasticSearchThrift::Client do
  let(:client) { make_client }

  it "executes requests and returns the response" do
    with_thrift_client do |client|
      response = client.request(ElasticSearchThrift::Method::GET, '/', {})
      response.status.must_equal 200
      response.headers.must_be_nil
      response.data['version'].wont_be_nil
    end
  end

  it "performs GET, POST, PUT, and DELETE requests properly" do
    with_http_client do |http|
      with_thrift_client do |thrift|
        thrift.put("/#{INDEX}")

        status = JSON.parse(http.get("/#{INDEX}/_status").body)
        status['indices'].keys.must_include INDEX

        thrift.post("/#{INDEX}/thing", {'refresh' => 'true'}, {name: 'a'})

        response = thrift.get("/#{INDEX}/thing/_search")
        response.data['hits']['total'].must_equal 1

        id = response.data['hits']['hits'][0]['_id']
        thrift.delete("/#{INDEX}/thing/#{id}", {'refresh' => 'true'})

        response = thrift.get("/#{INDEX}/thing/_search")
        response.data['hits']['total'].must_equal 0
      end
    end
  end
end
