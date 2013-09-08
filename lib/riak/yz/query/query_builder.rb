module Riak
  module Yz
    module Query
      class QueryBuilder
        def initialize(bucket)
          @bucket = bucket
        end

        def where(opts)
          where_clauses.merge! opts

          self
        end

        def keys
          results['docs'].map{|d| d['_yz_rk']}
        end

        def to_yz_query
          where_clauses.map do |k,v|
            "#{k}:#{v}"
          end.join ' AND '
        end

        private
        def results
          @results ||= @bucket.client.search @bucket.name, to_yz_query
        end

        def where_clauses
          @where_clauses ||= Hash.new
        end
      end
    end
  end
end
