require 'rubygems'
require 'specinfra'
require 'rspec'
require 'rspec/its'
require 'serverspec/version'
require 'serverspec/matcher'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/subject'
require 'serverspec/commands/base'
require 'rspec/core/formatters/base_formatter'
require 'specinfra/helper/set'
include Specinfra::Helper::Set

module RSpec::Core::Notifications
  class FailedExampleNotification < ExampleNotification
    def failure_lines
      host = ENV['TARGET_HOST'] || Specinfra.configuration.host
      @failure_lines ||=
        begin
          lines = []
          lines << "On host `#{host}'" if host
          lines << "Failure/Error: #{read_failed_line.strip}"
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
