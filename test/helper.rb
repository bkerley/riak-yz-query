require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'shoulda/context'

class TestCase < MiniTest::Unit::TestCase
  include ShouldaContextLoadable
end
