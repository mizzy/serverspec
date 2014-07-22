require 'spec_helper'

set :os, :family => 'arch'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Arch::Base::Service) }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

