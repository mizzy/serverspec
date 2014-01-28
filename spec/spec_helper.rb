require 'serverspec'
require 'pathname'
require 'rspec/mocks/standalone'

include SpecInfra::Helper::Exec

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }


module SpecInfra
  module Backend
    module TestCommandRunner
      def do_run cmd
        if @example
          @example.metadata[:subject].set_command(cmd)
        end

        CommandResult.new({
          :stdout      => ::SpecInfra.configuration.stdout,
          :stderr      => ::SpecInfra.configuration.stderr,
          :exit_status => cmd =~ /invalid/ ? 1 : 0,
          :exit_signal => nil,
        })

      end
    end
    [Exec, Ssh, Cmd, WinRM].each do |clz|
      clz.class_eval do
        include TestCommandRunner
        def run_command(cmd)
          cmd = build_command(cmd.to_s)
          cmd = add_pre_command(cmd)
          do_run cmd
        end
      end
    end
  end
end

module Serverspec
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
