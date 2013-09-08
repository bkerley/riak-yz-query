# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riak/yz/query/version'

Gem::Specification.new do |spec|
  spec.name          = "riak-yz-query"
  spec.version       = Riak::Yz::Query::VERSION
  spec.authors       = ["Bryce Kerley"]
  spec.email         = ["bkerley@brycekerley.net"]
  spec.description   = %q{Arel-style queries for Riak Yokozuna}
  spec.summary       = %q{Arel-style queries for Riak Yokozuna}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 4.7"
  spec.add_development_dependency "shoulda-context", "~> 1.1.5"

  spec.add_dependency 'riak-client'
end
