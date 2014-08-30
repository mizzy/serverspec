require 'serverspec'

set :backend, :exec

module Specinfra
  module Backend
    class Exec < Base
      def run_command cmd
        CommandResult.new({
          :stdout      => ::Specinfra.configuration.stdout,
          :stderr      => ::Specinfra.configuration.stderr,
          :exit_status => 0,
          :exit_signal => nil,
        })
      end
    end
    class Cmd < Base
      def run_command cmd
        CommandResult.new({
          :stdout      => ::Specinfra.configuration.stdout,
          :stderr      => ::Specinfra.configuration.stderr,
          :exit_status => 0,
          :exit_signal => nil,
        })
      end
    end
  end
end
