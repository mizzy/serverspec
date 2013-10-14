require 'spec_helper'
require 'support/powershell_command_runner'

include Serverspec::Helper::Cmd
include Serverspec::Helper::Windows

RSpec.configure do |c|
  c.os = 'Windows'
end

describe "Cmd" do
  it_behaves_like "a powershell command runner"
end
