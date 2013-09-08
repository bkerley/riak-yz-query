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
        when String
          @clause
        end
      end

      def consume(new_clause)
        if @clause.is_a? Hash and new_clause.is_a? Hash
          return self.class.new(@clause.merge new_clause)
        end

        if @clause.empty?
          return self.class.new new_clause
        end

        return self.class.new "(#{to_yz_query}) AND #{new_clause}"
      end
    end
  end
end
