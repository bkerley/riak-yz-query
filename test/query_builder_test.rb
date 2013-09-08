require 'helper'

class QueryBuilderTest < TestCase
  context "a QueryBuilder" do
    setup do
      @bucket = client.bucket 'user'
    end

    should "chain from 'where'" do
      q = @bucket.query
      q_where = q.where(asdf: 'asdf')
      refute_equal q, q_where
      assert_instance_of Riak::YzQuery::QueryBuilder, q_where
    end

    should "convert to a yokozuna query" do
      q = @bucket.query.where(asdf: 'jkl')
      assert_equal 'asdf:"jkl"', q.to_yz_query
    end

    should "query on #keys" do
      q = @bucket.query
      client.
        expects(:search).
        with(@bucket.name, 'asdf:"jkl"', {limit: nil, offset: nil}).
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

    context 'where clauses' do
      should 'support hashes' do
        assert_produces 'asdf:"jkl"', {asdf: 'jkl'}
        assert_produces 'asdf:"jkl"', {'asdf' => 'jkl'}
      end
      should 'support strings' do
        assert_produces 'asdf:jkl', 'asdf:jkl'
      end
      should 'support arrays with interpolation' do
        assert_produces 'asdf:"jkl"', ['asdf:?', 'jkl']
      end
    end
  end

  def assert_produces(desired_query, *clause)
    assert_equal(desired_query,
                 @bucket.query.where(*clause).to_yz_query,
                 "Clause #{clause.inspect} did not produce expected query #{desired_query.inspect}")
  end
end
