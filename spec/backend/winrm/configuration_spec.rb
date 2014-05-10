require 'spec_helper'
require 'support/powershell_command_runner'

include SpecInfra::Helper::WinRM
include SpecInfra::Helper::Windows

describe "WinRM" do
  it_behaves_like "a powershell command runner"
end
