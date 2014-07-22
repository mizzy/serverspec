require 'spec_helper'

set :os, :family => 'ubuntu'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Ubuntu::Base::Service) }
end

describe service('sshd') do
  it { should be_running }
end

describe service('invalid-service') do
  it { should_not be_running }
end
