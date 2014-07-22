require 'spec_helper'

set :os, :family => 'fedora', :release => 20

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Fedora::V15::Service) }
end

describe service('sshd') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
end

describe service('sshd') do
  it { should be_running }
end
