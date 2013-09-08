module Riak
  module Yz
    module Query
      class QueryBuilder
        def initialize(bucket)
          @bucket = bucket
        end

        def initialize_from_opts(opts)
          @bucket = opts[:bucket]
          where_clauses.merge! opts[:where_clauses]
        end

        def where(opts)
          chain where_clauses: where_clauses.merge(opts)
        end

        def keys
          @keys ||= results['docs'].map{|d| d['_yz_rk']}
        end

        def to_yz_query
          where_clauses.map do |k,v|
            "#{k}:#{v}"
          end.join ' AND '
        end

        private
        def chain(opts)
          new_options = {
            bucket: @bucket,
            where_clauses: where_clauses
          }.merge opts

          chain = self.class.allocate
          chain.initialize_from_opts new_options

          return chain
        end

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
