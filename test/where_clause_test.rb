require 'helper'

class WhereClauseTest < TestCase
  context 'a WhereClause' do
    should 'merge a hash and a hash' do
      c = WhereClause.new asdf: 'jkl'
      c_merge = c.consume qwe: 'rty'
      assert_equal 'asdf:jkl and qwe:rty', c_merge.to_yz_query
    end

    should 'merge a hash and a string' do
      c = WhereClause.new asdf: 'jkl'
      c_merge = c.consume 'qwe:rty'
      assert_equal 'asdf:jkl and qwe:rty', c_merge_to_yz_query
    end

    should 'merge a string and a string' do
      c = WhereClause.new "bryce:hello"
      c_merge = c.consume "hello:to_u"
      assert_equal "(bryce:hello) AND hello:to_u"
    end

    should 'escape an array into a string'
  end
end
