require 'helper'

class IntegrationTest < TestCase
  context 'riak-yz-query with some data' do
    setup do
      @bucket = client.bucket 'user'
    end

    should 'perform single-term queries' do
      results = @bucket.query.where(name_t: '*drew*')
      assert results
      refute_empty results
    end

    should 'perform multi-term queries'
    should 'perform range queries'
    should 'perform single-term queries with pagination controls'
  end
end
