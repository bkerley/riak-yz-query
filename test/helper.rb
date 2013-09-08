require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require 'shoulda/context'
require 'mocha/setup'

require 'riak'
require 'riak/yz/query'

class TestCase < MiniTest::Unit::TestCase
  include ShouldaContextLoadable

  def client
    @client ||= Riak::Client.new pb_port: 10017
  end

  def bucket_name
    return @bucket_name if defined? @bucket_name
    @bucket_name = "riak-yz-query-#{rand(36**10).to_s(36)}"
    $stderr.puts "Using bucket name #{@bucket_name.inspect}"
  end

  def bucket
    return @bucket if defined? @bucket

    @bucket = client.bucket bucket_name
  end

  
end

