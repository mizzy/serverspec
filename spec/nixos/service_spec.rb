require 'spec_helper'

include SpecInfra::Helper::NixOS

describe service('sshd') do
  it { should be_enabled }
  its(:command) { should eq "systemctl --plain list-dependencies multi-user.target | grep 'sshd.service$'" }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(3) }
  its(:command) { should eq "systemctl --plain list-dependencies multi-user.target | grep 'sshd.service$'" }
end

describe service('sshd') do
  it { should be_enabled.with_level("graphical.target") }
  its(:command) { should eq "systemctl --plain list-dependencies graphical.target | grep 'sshd.service$'" }
end

describe service('invalid-service') do
  it { should_not be_enabled.with_level(4) }
end

describe service('sshd') do
  it { should be_running }
  its(:command) { should eq "systemctl is-active sshd.service" }
end

describe service('invalid-daemon') do
  it { should_not be_running }
end

describe service('sshd') do
  let(:stdout) { "sshd is stopped\r\n" }
  it { should be_running }
end
