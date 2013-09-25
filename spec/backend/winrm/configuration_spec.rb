require 'spec_helper'
require 'support/powershell_command_runner'

RSpec.configure do |c|
  c.os      = 'Windows'
  c.backend = 'WinRM'
end

describe "WinRM" do
  it_behaves_like "a powershell command runner"
end
