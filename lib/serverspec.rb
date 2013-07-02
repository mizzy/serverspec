require 'rubygems'
require 'rspec'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/backend'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/subject'
require 'serverspec/commands/base'
require 'serverspec/commands/linux'
require 'serverspec/commands/redhat'
require 'serverspec/commands/debian'
require 'serverspec/commands/gentoo'
require 'serverspec/commands/solaris'
require 'serverspec/commands/solaris10'
require 'serverspec/commands/smartos'
require 'serverspec/commands/darwin'
require 'serverspec/configuration'
require 'rspec/core/formatters/base_formatter'

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
  c.include(Serverspec::Helper::RedHat,    :os => :redhat)
  c.include(Serverspec::Helper::Debian,    :os => :debian)
  c.include(Serverspec::Helper::Gentoo,    :os => :gentoo)
  c.include(Serverspec::Helper::Solaris,   :os => :solaris)
  c.include(Serverspec::Helper::Solaris10, :os => :solaris10)
  c.include(Serverspec::Helper::SmartOS,   :os => :smartos)
  c.include(Serverspec::Helper::Darwin,    :os => :darwin)
  c.add_setting :os,            :default => nil
  c.add_setting :host,          :default => nil
  c.add_setting :ssh,           :default => nil
  c.add_setting :sudo_password, :default => nil
  Serverspec.configuration.defaults.each { |k, v| c.add_setting k, :default => v }
  c.before :each do
    backend.set_example(example)
  end
end

module RSpec
  module Matchers
    module DSL
      class Matcher
        def failure_message_for_should(&block)
          message =  "#{example.metadata[:command]}\n"
          message += "#{example.metadata[:stdout]}"
          message
        end
        def failure_message_for_should_not(&block)
          message =  "#{example.metadata[:command]}\n"
          message += "#{example.metadata[:stdout]}"
          message
        end
      end
    end
  end
  module Core
    module Formatters
      class BaseTextFormatter < BaseFormatter
        def dump_failure_info(example)
          exception = example.execution_result[:exception]
          exception_class_name = exception_class_name_for(exception)
          output.puts "#{long_padding}#{failure_color("Failure/Error:")} #{failure_color(read_failed_line(exception, example).strip)}"
          output.puts "#{long_padding}#{failure_color(exception_class_name)}: #{failure_color(exception.message)}" unless exception_class_name =~ /RSpec/
          output.puts "#{long_padding}  #{failure_color(example.metadata[:command])}" if example.metadata[:command]
          output.puts "#{long_padding}  #{failure_color(example.metadata[:stdout])}" if example.metadata[:stdout] != ''
          exception.message.to_s.split("\n").each { |line| output.puts "#{long_padding}  #{failure_color(line)}" } if exception.message

          if shared_group = find_shared_group(example)
            dump_shared_failure_info(shared_group)
          end
        end
      end
      class ProgressFormatter < BaseTextFormatter
        def dump_failure_info(example)
          exception = example.execution_result[:exception]
          exception_class_name = exception_class_name_for(exception)
          output.puts "#{long_padding}#{failure_color("Failure/Error:")} #{failure_color(read_failed_line(exception, example).strip)}"
          output.puts "#{long_padding}#{failure_color(exception_class_name)}: #{failure_color(exception.message)}" unless exception_class_name =~ /RSpec/
          output.puts "#{long_padding}  #{failure_color(example.metadata[:command])}" if example.metadata[:command]
          output.puts "#{long_padding}  #{failure_color(example.metadata[:stdout])}" if example.metadata[:stdout] != ''
          exception.message.to_s.split("\n").each { |line| output.puts "#{long_padding}  #{failure_color(line)}" } if exception.message

          if shared_group = find_shared_group(example)
            dump_shared_failure_info(shared_group)
          end
        end
      end
    end
  end
end
