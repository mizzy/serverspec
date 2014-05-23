require 'rubygems'
require 'rspec'
require 'specinfra'
require 'serverspec/version'
require 'serverspec/matchers'
require 'serverspec/helper'
require 'serverspec/setup'
require 'serverspec/subject'
require 'serverspec/commands/base'
require 'rspec/core/formatters/base_formatter'

module RSpec
  module Core
    module Formatters
      class BaseTextFormatter < BaseFormatter
        # Follwoing code changes are made to print Evidence ( Real command that is executed at target machine and result of same)
        # To keep the changes minimal, I have overridden two methods of Class BaseTextFormatter 1. dump_failures 2. dump_failure_info(example)
        # These functions got overidden only if environment variable is set evidence=true
        if ENV['evidence'] == "true"
          def dump_failures
            output.puts
            output.puts "Evidence:"
            examples.each_with_index do |example, index|
              output.puts
              pending_fixed?(example) ? dump_pending_fixed(example, index) : dump_failure(example, index)
            end
          end
          def dump_failure_info(example)
            output.puts "#{long_padding} #{failure_color("Failure:")}" if example.execution_result[:status] == "failed"
            output.puts "#{long_padding} #{success_color("Success:")}" if example.execution_result[:status] == "passed"
            output.puts "#{long_padding} #{pending_color("Pending:")}" if example.execution_result[:status] == "pending"
	    output.puts "#{long_padding}  #{detail_color(example.metadata[:command])}" if example.metadata[:command]
            output.puts "#{long_padding}  #{detail_color(example.metadata[:stdout])}" if example.metadata[:stdout] != ''
            output.puts "#{long_padding} #{detail_color("#")} #{detail_color(RSpec::Core::Metadata::relative_path(example.location))}"
	  end
        else
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
      class ProgressFormatter < BaseTextFormatter
	# Follwoing code changes are made to print Evidence ( Real command that is executed at target machine and result of same)
        # To keep the changes minimal, I have overridden two methods of Class BaseTextFormatter 1. dump_failures 2. dump_failure_info(example)
        # These functions got overidden only if environment variable is set evidence=true
	if ENV['evidence'] == "true"
          def dump_failures
            output.puts
            output.puts "Evidence:"
            examples.each_with_index do |example, index|
              output.puts
              pending_fixed?(example) ? dump_pending_fixed(example, index) : dump_failure(example, index)
	    end
          end
          def dump_failure_info(example)
	    output.puts "#{long_padding} #{failure_color("Failure:")}" if example.execution_result[:status] == "failed"
	    output.puts "#{long_padding} #{success_color("Success:")}" if example.execution_result[:status] == "passed"
	    output.puts "#{long_padding} #{pending_color("Pending:")}" if example.execution_result[:status] == "pending"
	    output.puts "#{long_padding}  #{bold(example.metadata[:command])}" if example.metadata[:command]
            output.puts "#{long_padding}  #{bold(example.metadata[:stdout])}" if example.metadata[:stdout] != ''
	    output.puts "#{long_padding} #{detail_color("#")} #{detail_color(RSpec::Core::Metadata::relative_path(example.location))}"
	  end
        else
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
end
