require 'serverspec'
require 'pathname'
require 'rspec/mocks/standalone'

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }


module Serverspec
  module Backend
    class Exec
      def run_command(cmd)
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
  end

  module Type
    class Base
      def command
        cmd = backend.build_command('command')
        backend.add_pre_command(cmd)
      end
    end
  end
end
