%w{bucket_extension version}.each do |f| 
  require "riak/yz/query/#{f}" 
end

module Riak
  module Yz
    module Query
      # Your code goes here...
    end
  end
end
