require 'spec_helper'

set :os, :family => 'suse'

describe commands.command_class('service').create do
  it { should be_an_instance_of(Specinfra::Command::Suse::Base::Service) }
end

describe service('sshd') do
  it { should be_enabled }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
end

describe service('invalid-service') do
  it { should_not be_enabled.with_level(4) }
end
