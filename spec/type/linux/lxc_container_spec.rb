require 'spec_helper'

set :os, :family => 'linux'

describe commands.command_class('lxc_container').create do
  it { should be_an_instance_of(Specinfra::Command::Linux::Base::LxcContainer) }
end

describe lxc('ct01') do
  it { should exist }
end

describe lxc('invalid-ct') do
  it { should_not exist }
end

describe lxc('ct01') do
  it { should be_running }
end

describe lxc('invalid-ct') do
  it { should_not be_running }
end

