require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

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

describe service('Test service') do
  it "should raise error if trying to check service process controller" do
   expect { should be_running.under('supervisor') }.to raise_error
 end
  it "should raise error if trying to check service monitoring" do
   expect { should_not be_monitored_by('monit') }.to raise_error
 end
end
