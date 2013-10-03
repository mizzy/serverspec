require 'serverspec'
require 'pathname'
require 'rspec/mocks/standalone'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }


module Serverspec
  module Backend
    module TestCommandRunner
      def do_run cmd
        if @example
          @example.metadata[:subject].set_command(cmd)
        end

        if cmd =~ /invalid/
          {
            :stdout      => ::Serverspec.configuration.stdout,
            :stderr      => ::Serverspec.configuration.stderr,
            :exit_status => 1,
            :exit_signal => nil
          }
        else
          {
            :stdout      => ::Serverspec.configuration.stdout,
            :stderr      => ::Serverspec.configuration.stderr,
            :exit_status => 0,
            :exit_signal => nil
          }
        end
      end
    end
    [Exec, Ssh].each do |clz|
      clz.class_eval do
        include TestCommandRunner
        def run_command(cmd)
          cmd = build_command(cmd)
          cmd = add_pre_command(cmd)
          do_run cmd
        end
      end
    end
    [Cmd, WinRM].each do |clz|
      clz.class_eval do
        include TestCommandRunner
        def run_command(cmd)
          cmd = build_command(cmd.script)
          cmd = add_pre_command(cmd)
          do_run cmd
        end
      end
    end
  end

  module Type
    class Base
      def set_command(command)
        @command = command
      end
      def command
        @command
      end
    end
  end
end
