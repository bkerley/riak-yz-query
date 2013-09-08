require 'helper'

class IntegrationTest < TestCase
  context 'riak-yz-query with some data' do
    should 'perform single-term queries'
    should 'perform multi-term queries'
    should 'perform range queries'
    should 'perform single-term queries with pagination controls'
  end
end
