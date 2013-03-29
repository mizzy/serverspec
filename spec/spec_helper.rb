require 'serverspec'
require 'pathname'

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }

module Serverspec
  module SshHelper
    def ssh_exec(cmd)
      if cmd =~ /invalid/
        { :stdout => nil, :stderr => nil, :exit_code => 1, :exit_signal => nil }
      else
        { :stdout => nil, :stderr => nil, :exit_code => 0, :exit_signal => nil }
      end
    end
  end
end
