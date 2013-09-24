require 'spec_helper'
require 'support/powershell_command_runner'

include Serverspec::Helper::Cmd
include Serverspec::Helper::Windows

describe "Cmd" do
  it_behaves_like "a powershell command runner"
end
