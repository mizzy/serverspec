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
            :stdout      => ::RSpec.configuration.stdout,
            :stderr      => ::RSpec.configuration.stderr,
            :exit_status => 1,
            :exit_signal => nil
          }
        else
          {
            :stdout      => ::RSpec.configuration.stdout,
            :stderr      => ::RSpec.configuration.stderr,
            :exit_status => 0,
            :exit_signal => nil
          }
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.add_setting :stdout, :default => ''
  c.add_setting :stderr, :default => ''
  c.include(Serverspec::Helper::Exec, :backend => :exec)
  c.include(Serverspec::Helper::Ssh,  :backend => :ssh)
end
