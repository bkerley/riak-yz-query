%w{where_clause bucket_extension version}.each do |f| 
  require "riak/yz_query/#{f}" 
end

module Riak
  module YzQuery
  end
end
