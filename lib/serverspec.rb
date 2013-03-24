require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/commands/base'
require 'serverspec/commands/redhat'

RSpec.configure do |c|
  c.include(Serverspec::Helper)
  c.include(Serverspec::RedhatHelper, :serverspec => :redhat)
  c.add_setting :host, :default => nil
end
