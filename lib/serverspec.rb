require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/backend'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/filter'
require 'serverspec/subject'
require 'serverspec/commands/base'
require 'serverspec/commands/linux'
require 'serverspec/commands/redhat'
require 'serverspec/commands/debian'
require 'serverspec/commands/gentoo'
require 'serverspec/commands/solaris'
require 'serverspec/commands/darwin'
require 'serverspec/configuration'

include Serverspec

module Serverspec
  class << self
    def configuration
      Serverspec::Configuration
    end
  end
end

RSpec.configure do |c|
  c.include(Serverspec::Helper::Configuration)
  c.include(Serverspec::Helper::RedHat,  :os => :redhat)
  c.include(Serverspec::Helper::Debian,  :os => :debian)
  c.include(Serverspec::Helper::Gentoo,  :os => :gentoo)
  c.include(Serverspec::Helper::Solaris, :os => :solaris)
  c.include(Serverspec::Helper::Darwin,  :os => :darwin)
  c.add_setting :os,            :default => nil
  c.add_setting :host,          :default => nil
  c.add_setting :ssh,           :default => nil
  c.add_setting :sudo_password, :default => nil
  Serverspec.configuration.defaults.each { |k, v| c.add_setting k, :default => v }
  c.before :each do
    backend.set_example(example)
    if described_class.nil? && subject == 'value'
      def subject
        Serverspec::Filter.filter_subject example
      end
    end
  end
end

module RSpec
  module Matchers
    module DSL
      class Matcher
        def failure_message_for_should(&block)
          if block.to_s =~ /serverspec\/matchers\/.+\.rb/
            @custom = true
          end
          if @custom
            cache_or_call_cached(:failure_message_for_should, &block)
          else
            message =  "#{example.metadata[:command]}\n"
            message += "#{example.metadata[:stdout]}"
            message
          end
        end
        def failure_message_for_should_not(&block)
          if block.to_s =~ /serverspec\/matchers\/.+\.rb/
            @custom = true
          end
          if @custom
            cache_or_call_cached(:failure_message_for_should, &block)
          else
            message =  "#{example.metadata[:command]}\n"
            message += "#{example.metadata[:stdout]}"
            message
          end
        end
      end
    end
  end
end
