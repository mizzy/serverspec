require 'spec_helper'
require 'support/powershell_command_runner'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe "Cmd" do
  it_behaves_like "a powershell command runner"
end
