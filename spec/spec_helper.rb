require 'serverspec'
require 'pathname'

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }

module Serverspec
  module SshHelper
    def do_check(cmd)
      if cmd =~ /invalid/
        { :stdout => '', :stderr => '', :exit_code => 1, :exit_signal => nil }
      else
        { :stdout => ::RSpec.configuration.stdout, :stderr => '', :exit_code => 0, :exit_signal => nil }
      end
    end
  end
end

RSpec.configure do |c|
  c.add_setting :stdout, :default => ''
end
