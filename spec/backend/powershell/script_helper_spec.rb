require 'spec_helper'

include SpecInfra::Backend::PowerShell::ScriptHelper

describe 'build command with path' do
  before :each do
    RSpec.configure do |c|
      c.path = 'c:/test/path/bin'
    end
  end

  it "should prefix the command with the path instruction" do 
    cmd = build_command('run_script -f param')
    cmd.should eq <<-eof
$env:path = "c:/test/path/bin;$env:path"
run_script -f param
eof
  end

  after :each do
    RSpec.configure do |c|
      c.path = nil
    end
  end
end

describe 'add pre-command' do
  before :each do
    SpecInfra.configuration.pre_command = 'test_pre_command'
  end

  it "should add the test for pre_command before the command" do
    cmd = add_pre_command('run_script -f param')
    cmd.should eq <<-eof
if (test_pre_command)
{
run_script -f param
}
eof
  end

  context "with path" do
    before :each do
      RSpec.configure do |c|
        c.path = 'c:/test/path/bin'
      end
    end

  it "should add the path instruction and the test for pre_command before the command" do
    cmd = add_pre_command('run_script -f param')
    cmd.should eq <<-eof
$env:path = "c:/test/path/bin;$env:path"
if (test_pre_command)
{
run_script -f param
}
eof
  end

    after :each do
      RSpec.configure do |c|
        c.path = nil
      end
    end
  end

  after :each do
    SpecInfra.configuration.pre_command = nil
  end
end

describe "script encoding" do
  it "should encode the given script" do
    script = encode_script("test_powershell_script")
    script.should == "dABlAHMAdABfAHAAbwB3AGUAcgBzAGgAZQBsAGwAXwBzAGMAcgBpAHAAdAA="
  end
end

describe 'script creation' do
  context "powershell command" do
    File.should_receive(:read).with(/test_function1.ps1/).and_return 'function test1'
    command = Backend::PowerShell::Command.new do
      using 'test_function1.ps1'
      exec 'test command'
    end
    script = create_script command
    script.should == <<-eof
$exitCode = 1
$ProgressPreference = "SilentlyContinue"
try {
  function test1
  $success = (test command)
  if ($success -is [Boolean] -and $success) { $exitCode = 0 }
} catch {
  Write-Output $_.Exception.Message
}
Write-Output "Exiting with code: $exitCode"
exit $exitCode
eof
  end

  context 'simple command' do
    create_script('test command').should == 'test command'
  end
end
