require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/backend'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/commands/base'
require 'serverspec/commands/redhat'
require 'serverspec/commands/debian'
require 'serverspec/commands/gentoo'
require 'serverspec/commands/solaris'

RSpec.configure do |c|
  c.include(Serverspec::Helper::RedHat,  :os => :redhat)
  c.include(Serverspec::Helper::Debian,  :os => :debian)
  c.include(Serverspec::Helper::Gentoo,  :os => :gentoo)
  c.include(Serverspec::Helper::Solaris, :os => :solaris)
  c.add_setting :os,            :default => nil
  c.add_setting :host,          :default => nil
  c.add_setting :ssh,           :default => nil
  c.add_setting :sudo_password, :default => nil
end
