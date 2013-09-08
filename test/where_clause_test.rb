require 'helper'

class WhereClauseTest < TestCase
  WhereClause = Riak::YzQuery::WhereClause

  context 'a WhereClause' do
    should 'merge a hash and a hash' do
      c = WhereClause.new asdf: 'jkl'
      c_merge = c.consume qwe: 'rty'
      assert_equal 'asdf:"jkl" AND qwe:"rty"', c_merge.to_yz_query
    end

    should 'merge a hash and a string' do
      c = WhereClause.new asdf: 'jkl'
      c_merge = c.consume 'qwe:rty'
      assert_equal '(asdf:"jkl") AND qwe:rty', c_merge.to_yz_query
    end

    should 'merge a string and a hash' do
      c = WhereClause.new 'qwe:rty'
      c_merge = c.consume asdf: 'jkl'
      assert_equal '(qwe:rty) AND asdf:"jkl"', c_merge.to_yz_query
    end

    should 'merge a string and a string' do
      c = WhereClause.new "bryce:hello"
      c_merge = c.consume "hello:to_u"
      assert_equal '(bryce:hello) AND hello:to_u', c_merge.to_yz_query
    end

    should 'escape an array into a string' do
      c = WhereClause.new ["bryce:? OR bryce:?", 'hi', 'hello']
      assert_equal 'bryce:"hi" OR bryce:"hello"', c.to_yz_query
    end
  end
end
