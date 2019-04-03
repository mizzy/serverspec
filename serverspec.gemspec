# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serverspec/version'

Gem::Specification.new do |spec|
  spec.name          = "serverspec"
  spec.version       = Serverspec::VERSION
  spec.authors       = ["Gosuke Miyashita"]
  spec.email         = ["gosukenator@gmail.com"]
  spec.description   = %q{RSpec tests for your servers configured by Puppet, Chef, Itamae or anything else}
  spec.summary       = %q{RSpec tests for your servers configured by Puppet, Chef, Itamae or anything else}
  spec.homepage      = "http://serverspec.org/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "rspec-its"
  spec.add_runtime_dependency "multi_json"
  spec.add_runtime_dependency "specinfra", "~> 2.72"
  spec.add_development_dependency("json", "~> 1.8") if RUBY_VERSION < "1.9"
  spec.add_development_dependency "rake", "~> 10.1.1"
end
