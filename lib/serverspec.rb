require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/commands/base'
require 'serverspec/commands/redhat'
require 'serverspec/commands/debian'

RSpec.configure do |c|
  c.include(Serverspec::Helper)
  c.include(Serverspec::RedHatHelper, :serverspec => :redhat)
  c.include(Serverspec::DebianHelper, :serverspec => :debian)
  c.add_setting :host, :default => nil
end
