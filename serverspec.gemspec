# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serverspec/version'

Gem::Specification.new do |spec|
  spec.name          = "serverspec"
  spec.version       = Serverspec::VERSION
  spec.authors       = ["Gosuke Miyashita"]
  spec.email         = ["gosukenator@gmail.com"]
  spec.description   = %q{RSpec tests for your servers provisioned by Puppet, Chef or anything else}
  spec.summary       = %q{RSpec tests for your servers provisioned by Puppet, Chef or anything else}
  spec.homepage      = "http://serverspec.org/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "net-ssh"
  spec.add_dependency "puppet"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
