require 'helper'
require 'time'

class IntegrationTest < TestCase
  context 'riak-yz-query with some data' do
    setup do
      @bucket = client.bucket 'user'
    end

    should 'perform single-term queries' do
      q = @bucket.query.where(name_t: '*drew*')
      ['Z0tsBudxTQp50pBlTNeBw6CtwZx',
       'PtgA5YsxWpSg7RzTY2eJVJ81hDQ',
       'OL1quOfOKiYEmxYsqvjf9cyRmH3'].each do |k|
        assert_includes q.keys, k
      end
    end

    should 'perform multi-term AND queries' do
      q = @bucket.query.where(name_t: '*drew*', title_t: '*engineer*')
      ['Z0tsBudxTQp50pBlTNeBw6CtwZx',
       'PtgA5YsxWpSg7RzTY2eJVJ81hDQ'].each do |k|
        assert_includes q.keys, k
      end
      ['OL1quOfOKiYEmxYsqvjf9cyRmH3'].each do |k|
        refute_includes q.keys, k
      end
    end

    should 'perform multi-term OR queries' do
      q = @bucket.query.where(['name_t:? OR name_t:?', 'Drew', 'Bryce'])
      ['Z0tsBudxTQp50pBlTNeBw6CtwZx',
       'Hswdh9zli0CDcnPSKmEGeIcd6tU'].each do |k|
        assert_includes q.keys, k
      end
    end

    should 'perform range queries with times' do
      open = Time.parse '2007-12-10T23:59:59Z'
      close = Time.parse '2007-12-20T23:59:59Z'
      q = @bucket.query.where created_dt: (open..close)

      assert_includes q.keys, 'Hswdh9zli0CDcnPSKmEGeIcd6tU'
    end
    should 'perform single-term queries with pagination controls'
  end
end
