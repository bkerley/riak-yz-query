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
      assert_includes q.keys, 'PtgA5YsxWpSg7RzTY2eJVJ81hDQ'
    end

    should 'perform multi-term AND queries' do
      q = @bucket.query.where(name_t: '*drew*', title_t: '*engineer*')
      assert q
      refute_empty q.keys
    end

    should 'perform multi-term OR queries'

    should 'perform range queries'
    should 'perform single-term queries with pagination controls'
  end
end
