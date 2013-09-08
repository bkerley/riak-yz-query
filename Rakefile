require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new :test do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/*_test.rb'
end
