require 'spec_helper'

set :os, :family => 'nixos'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Nixos::Base::Service) }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

