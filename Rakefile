require 'ritual'

task :configure do
  FileUtils.mkdir_p 'config'
  system "curl https://raw.github.com/elasticsearch/elasticsearch-transport-thrift/master/elasticsearch.thrift > config/elasticsearch.thrift"
  system "sed -i '' -e 's|namespace rb ElasticSearch.Thrift|namespace rb ElasticSearchThrift|' config/elasticsearch.thrift"
end

task :thrift do
  system "thrift --gen rb -out lib/elastic_search_thrift config/elasticsearch.thrift"

  Dir['lib/elastic_search_thrift/{elasticsearch_constants,elasticsearch_types,rest}.rb'].each do |path|
    system "sed -i '' -e \"s|require 'thrift'|require 'elastic_search_thrift/mini_thrift'|\" #{path}"
    system "sed -i '' -e \"s|require 'elasticsearch_types'|require 'elastic_search_thrift/elasticsearch_types'|\" #{path}"
  end
end
