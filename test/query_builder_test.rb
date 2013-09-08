require 'helper'

class QueryBuilderTest < TestCase
  context "a QueryBuilder" do
    setup do
      @bucket = client.bucket 'user'
    end

    should "chain from 'where'" do
      q = @bucket.query
      assert_equal q, q.where(asdf: 'asdf')
    end

    should "convert to a yokozuna query" do
      q = @bucket.query.where(asdf: 'jkl')
      assert_equal "asdf:jkl", q.to_yz_query
    end

    should "query on #keys" do
      q = @bucket.query
      client.
        expects(:search).
        with(@bucket.name, 'asdf:jkl').
        returns({
                  'docs' => [
                             'score' => 1.0,
                             '_yz_rk' => 'jkl',
                            ],
                  'max_score' => 1.0,
                  'num_found' => 1
                })

      keys = q.where(asdf: 'jkl').keys
      assert_equal ['jkl'], keys
    end
  end
end
