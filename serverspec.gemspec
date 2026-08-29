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

  # net-ssh (pulled in via specinfra) requires "logger" at load time. As of
  # Ruby 3.5 / 4.0 "logger" is a bundled gem rather than a default gem, so it
  # is not on the load path inside a bundle unless it is declared here.
  spec.add_runtime_dependency "logger"

  if RUBY_VERSION < "1.9"
    spec.add_development_dependency "json", "~> 1.8"
    spec.add_development_dependency "rake", "~> 10.1.1"
  else
    spec.add_development_dependency "rake"
  end
end
