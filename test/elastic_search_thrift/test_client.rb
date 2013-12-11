require_relative '../test_helper'

describe ElasticSearchThrift::Client do
  let(:client) { make_client }

  it "executes requests and returns the response" do
    client = make_client
    response = client.open do
      client.request(ElasticSearchThrift::Method::GET, '/', {})
    end
    response['status'].must_equal 200
    response['version'].wont_be_nil
  end
end
