require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'

RSpec.configure do |c|
  c.include(Serverspec::Helper)
  c.add_setting :host, :default => nil
end
