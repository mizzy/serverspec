require 'spec_helper'
require 'support/powershell_command_runner'

include Serverspec::Helper::WinRM
include Serverspec::Helper::Windows

RSpec.configure do |c|
  c.os = 'Windows'
end

describe "WinRM" do
  it_behaves_like "a powershell command runner"
end
