require 'time'

module Riak
  module YzQuery
    class WhereClause
      def initialize(clause)
        @clause = clause
      end

      def to_yz_query
        case @clause
        when Hash
          build_clause_hash
        when Array
          escape_clause_array
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

        new_clause_query = self.class.new(new_clause).to_yz_query

        return self.class.new "(#{to_yz_query}) AND #{new_clause_query}"
      end

      private
      def build_clause_hash
        @clause.map do |k,v|
          "#{k}:#{escape v}"
        end.join ' AND '
      end

      def escape_clause_array
        working = @clause.first.dup
        remaining = @clause[1..-1].dup

        while remaining.length > 0
          working['?'] = escape remaining.shift
        end

        working
      end

      def escape(candidate)
        case candidate
        when Range
          return "[#{escape(candidate.begin)} TO #{escape(candidate.end)}]"
        when Time
          return candidate.iso8601
        else
          escape_string candidate.to_s
        end
      end

      def escape_string(str)
        if (str.include? ' ' or str.include? '"') and str.include? '*'
          raise ArgumentError.new "Couldn't figure out how to escape #{str.inspect}" 
        end

        if str.include? '*'
          return str
        end

        return %Q{"#{str}"}
      end
    end
  end
end
