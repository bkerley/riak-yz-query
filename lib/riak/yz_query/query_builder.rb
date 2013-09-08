module Riak
  module YzQuery
    class QueryBuilder
      def initialize(bucket)
        @bucket = bucket
      end

      def initialize_from_opts(opts)
        @bucket = opts[:bucket]
        @where_clauses = opts[:where_clauses]
        @limit = opts[:limit]
        @offset = opts[:offset]
      end

      def where(opts)
        chain where_clauses: where_clauses.consume(opts)
      end

      def limit(lim)
        chain limit: lim
      end

      def offset(off)
        chain offset: off
      end

      def keys
        @keys ||= results['docs'].map{|d| d['_yz_rk']}
      end

      def to_yz_query
        where_clauses.to_yz_query
      end

      private
      def chain(opts)
        new_options = {
          bucket: @bucket,
          where_clauses: where_clauses,
          limit: @limit,
          offset: @offset
        }.merge opts

        chain = self.class.allocate
        chain.initialize_from_opts new_options

        return chain
      end

      def results
        @results ||= @bucket.client.search @bucket.name, to_yz_query, limit: @limit, offset: @offset
      end

      def where_clauses
        @where_clauses ||= WhereClause.new Hash.new
      end
    end
  end
end
