require 'helper'

class IntegrationTest < TestCase
  context 'riak-yz-query with some data' do
    setup do
      @bucket = client.bucket 'user'
    end

    should 'perform single-term queries' do
      q = @bucket.query.where(name_t: '*drew*')
      assert q
      refute_empty q.keys
    end

    should 'perform multi-term queries' do
      q = @bucket.query.where(name_t: '*drew*', title_t: '*engineer*')
      assert q
      refute_empty q.keys
    end

    should 'perform range queries'
    should 'perform single-term queries with pagination controls'
  end
end
