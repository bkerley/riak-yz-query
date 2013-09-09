# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riak/yz_query/version'

Gem::Specification.new do |spec|
  spec.name          = "riak-yz-query"
  spec.version       = Riak::YzQuery::VERSION
  spec.authors       = ["Bryce Kerley"]
  spec.email         = ["bkerley@brycekerley.net"]
  spec.description   = %q{Arel-style queries for Riak Yokozuna}
  spec.summary       = %q{Arel-style queries for Riak Yokozuna}
  spec.homepage      = "https://github.com/bkerley/riak-yz-query"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '> 2.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 4.7"
  spec.add_development_dependency "shoulda-context", "~> 1.1.5"
  spec.add_development_dependency "mocha", "~> 0.14.0"

  spec.add_dependency 'riak-client'
end
