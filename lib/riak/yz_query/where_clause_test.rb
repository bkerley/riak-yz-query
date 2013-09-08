require 'helper'

class WhereClauseTest < TestCase
  context 'a WhereClause' do
    should 'merge a hash and a hash' do
      c = WhereClause.new asdf: 'jkl'
      c_merge = c.consume qwe: 'rty'
      assert_equal 'asdf:jkl and qwe:rty', c_merge.to_yz_query
    end

    should 'merge a hash and a string'
    should 'merge a string and a string'
    should 'escape an array into a string'
  end
end
