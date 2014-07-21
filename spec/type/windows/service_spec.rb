require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::Service) }
end

describe service('Test Service') do
  it { should be_enabled }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('Test Service') do
  it { should be_running }
end

describe service('invalid-daemon') do
  it { should_not be_running }
end

describe service('service') do
  it { should be_installed }
end

describe service('service') do
  it { should have_start_mode 'mode' }
end

describe service('Test service') do
  it "should raise error if trying to check service process controller" do
   expect { should be_running.under('supervisor') }.to raise_error
 end
  it "should raise error if trying to check service monitoring" do
   expect { should_not be_monitored_by('monit') }.to raise_error
 end
end
