require 'spec_helper'

include SpecInfra::Helper::Plamo

describe lxc('ct01') do
  it { should exist }
  its(:command) { should eq "lxc-ls -1 | grep -w ct01" }
end

describe lxc('invalid-ct') do
  it { should_not exist }
end

describe lxc('ct01') do
  it { should be_running }
  its(:command) { should eq "lxc-info -n ct01 -s | grep -w RUNNING"}
end

describe lxc('invalid-ct') do
  it { should_not be_running }
end

