require 'spec_helper'

include SpecInfra::Helper::RedHat7

describe service('sshd') do
  it { should be_enabled }
  its(:command) { should eq "systemctl --plain list-dependencies runlevel3.target | grep '^sshd.service$'" }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
  its(:command) { should eq "systemctl --plain list-dependencies runlevel4.target | grep '^sshd.service$'" }
end

describe service('invalid-service') do
  it { should_not be_enabled.with_level(4) }
end
