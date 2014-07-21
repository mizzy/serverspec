require 'spec_helper'

set :os, :family => 'smartos'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Smartos::Base::Service) }
end

describe service('sshd') do
  it { should be_enabled }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_running }
end

describe service('invalid-service') do
  it { should_not be_running }
end

describe service('sshd') do
  it { should have_property :foo => 'bar' }
end

describe service('invalid-service') do
  it { should_not have_property :foo => 'bar' }
end

