require 'faraday'
require 'logger'

require_relative 'utils'
require_relative 'base'

module Kishu
  module Event 

    API_URL = "https://api.datacite.org"

    def initialize
      @client = Elasticsearch::Client.new host: 'localhost:9200', transport_options: { request: { timeout: 3600, open_timeout: 3600 } }
    end


    def get options={}
      x =@client.search(body:{
          size: options[:size] || 0,
          query: {
            query_string: {
              query: "*"
            }
          },
          aggregations: aggregations(options)
        },
        index: "resolutions"
        )
      puts x.class
      x.dig("aggregations","doi","buckets")
    end

    def aggregations options={}
      {
        doi: {composite: {
          sources: [{doi: {terms: {field: :doi	}}}],
          after: { doi: options[:after_key] || "" },
          size: options[:aggs_size] || 102
          },
          aggs: {
            unique: {terms: {field: "unique_usage"}},
            totale: {terms: {field: "total_usage"	}}
          }
        }
      }
    end

  end
end

