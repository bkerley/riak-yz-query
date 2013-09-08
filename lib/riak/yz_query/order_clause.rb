module Riak
  module YzQuery
    class OrderClause
      def initialize(clause)
        @clause = clause
      end

      def to_yz_query
        return nil if @clause.empty?

        case @clause
        when Hash
          build_clause_hash
        when Array
          build_clause_array
        when String
          @clause
        end
      end
      
      def consume(new_clause)
        new_clause_query = self.class.new(new_clause)
        return new_clause_query if @clause.empty?
        return self.class.new "#{to_yz_query}, #{new_clause.to_yz_query}"
      end

      def build_clause_hash
        @clause.map do |k,v|
          v = v.to_s.downcase
          raise ArgumentError.new "Couldn't use #{v.inspect} in an order clause" unless %w{asc desc}.include? v

          "#{k} #{v}"
        end.join ', '
      end

      def build_clause_array
        @clause.join ', '
      end
    end
  end
end
