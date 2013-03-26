require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/commands/base'
require 'serverspec/commands/redhat'
require 'serverspec/commands/debian'
require 'serverspec/commands/solaris'

RSpec.configure do |c|
  c.include(Serverspec::Helper)
  c.include(Serverspec::RedHatHelper, :os => :redhat)
  c.include(Serverspec::DebianHelper, :os => :debian)
  c.include(Serverspec::SolarisHelper, :os => :solaris)
  c.add_setting :host, :default => nil
end
