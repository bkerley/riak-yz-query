require 'riak'
require 'riak/yz/query/query_builder'

module Riak
  module Yz
    module Query
      module BucketExtension
        def query
          QueryBuilder.new self
        end
      end
    end
  end

  class Bucket
    include Yz::Query::BucketExtension
  end
end
