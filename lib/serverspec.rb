require 'rubygems'
require 'rspec'
require 'rspec/its'
require 'specinfra'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/subject'
require 'serverspec/commands/base'
require 'rspec/core/formatters/base_formatter'

module RSpec::Core::Notifications
  class FailedExampleNotification < ExampleNotification
    def failure_lines
      @failure_lines ||=
        begin
          lines = ["Failure/Error: #{read_failed_line.strip}"]
          lines << "#{exception_class_name}:" unless exception_class_name =~ /RSpec/
          exception.message.to_s.split("\n").each do |line|
          lines << "  #{line}" if exception.message
        end
          lines << "  #{example.metadata[:command]}"
          lines << "  #{example.metadata[:stdout]}" if example.metadata[:stdout]
          lines << "  #{example.metadata[:stderr]}" if example.metadata[:stderr]
          lines
        end
    end
  end
end
