require 'spec_helper'

include Serverspec::Helper::Cmd
RSpec.configure do |c|
  c.os = 'Windows'
end

describe service('Test Service') do
  it { should be_enabled }
  its(:command) { should eq "(FindService -name 'Test Service').StartMode -eq 'Auto'" }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('Test Service') do
  it { should be_running }
  its(:command) { should eq "(FindService -name 'Test Service').State -eq 'Running'" }
end

describe service('invalid-daemon') do
  it { should_not be_running }
end
