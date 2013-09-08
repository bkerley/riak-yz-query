module Riak
  module YzQuery
    class WhereClause
      def initialize(clause)
        @clause = clause
      end

      def to_yz_query
        case @clause
        when Hash
          @clause.map do |k,v|
            "#{k}:#{v}"
          end.join ' AND '
        end
      end

      def consume(new_clause)
        if @clause.is_a? Hash and new_clause.is_a? Hash
          return self.class.new(@clause.merge new_clause)
        end
      end
    end
  end
end
