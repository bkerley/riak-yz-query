%w{bucket_extension version}.each do |f| 
  require "riak/yz_query/#{f}" 
end

module Riak
  module YzQuery
      # Your code goes here...
    end
  end
end
