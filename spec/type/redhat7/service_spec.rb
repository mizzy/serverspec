require 'spec_helper'

set :os, :family => 'redhat', :release => 7

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Redhat::V7::Service) }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

