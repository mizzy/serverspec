require 'spec_helper'
require 'support/powershell_command_runner'

include Serverspec::Helper::WinRM
include Serverspec::Helper::Windows

describe "WinRM" do
  it_behaves_like "a powershell command runner"
end
