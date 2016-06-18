require 'serverspec'

set :backend, :exec

module Specinfra
  module Backend
    class Exec < Base
      def run_command cmd
        CommandResult.new({
          :stdout      => ::Specinfra.configuration.stdout,
          :stderr      => ::Specinfra.configuration.stderr,
          :exit_status => ::Specinfra.configuration.exit_status,
          :exit_signal => nil,
        })
      end
    end
    class Cmd < Base
      def run_command cmd
        CommandResult.new({
          :stdout      => ::Specinfra.configuration.stdout,
          :stderr      => ::Specinfra.configuration.stderr,
          :exit_status => ::Specinfra.configuration.exit_status,
          :exit_signal => nil,
        })
      end
    end
  end
end

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout

  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
  end

  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
