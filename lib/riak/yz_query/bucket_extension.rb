require 'riak'
require 'riak/yz_query/query_builder'

module Riak
  module YzQuery
    module BucketExtension
      def query
        QueryBuilder.new self
      end
    end
  end

  class Bucket
    include YzQuery::BucketExtension
  end
end
