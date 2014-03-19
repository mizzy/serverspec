require 'spec_helper'

include SpecInfra::Helper::Fedora

# Fedora 15+

describe service('sshd') do
  it { should be_enabled }
  # TODO Find a way to make this default to multiuser.target instead
  its(:command) { should eq "systemctl --plain list-dependencies runlevel3.target | grep '^sshd.service$'" }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
  its(:command) { should eq "systemctl --plain list-dependencies runlevel4.target | grep '^sshd.service$'" }
end

describe service('sshd') do
  it { should be_enabled.with_level("graphical.target") }
  its(:command) { should eq "systemctl --plain list-dependencies graphical.target | grep '^sshd.service$'" }
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

# Fedora 14-

host = SpecInfra.configuration.ssh ? SpecInfra.configuration.ssh.host : 'localhost'

describe service('sshd') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should be_enabled }
  its(:command) { should eq "chkconfig --list sshd | grep 3:on" }
end

describe service('invalid-service') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should_not be_enabled }
end

describe service('sshd') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should be_enabled.with_level(4) }
  its(:command) { should eq "chkconfig --list sshd | grep 4:on" }
end

describe service('invalid-service') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should_not be_enabled.with_level(4) }
end

describe service('sshd') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should be_running }
  its(:command) { should eq "service sshd status" }
end

describe service('invalid-daemon') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  it { should_not be_running }
end

describe service('sshd') do
  before :each do
    set_property :os_by_host => { host => { :family => 'fedora', :release => '14' } }
  end
  after :each do
    property.delete :os_by_host
  end

  let(:stdout) { "sshd is stopped\r\n" }
  it { should be_running }
end

# All versions of Fedora

describe service('sshd') do
  it { should be_running.under('supervisor') }
  its(:command) { should eq "supervisorctl status sshd | grep RUNNING" }
end

describe service('invalid-daemon') do
  it { should_not be_running.under('supervisor') }
end

describe service('sshd') do
  it { should be_running.under('upstart') }
  its(:command) { should eq "initctl status sshd | grep running" }
end

describe service('invalid-daemon') do
  it { should_not be_running.under('upstart') }
end

describe service('sshd') do
  it {
    expect {
      should be_running.under('not implemented')
    }.to raise_error(ArgumentError, %r/\A`be_running` matcher doesn\'t support/)
  }
end

describe service('sshd') do
  let(:stdout) { "Process 'sshd'\r\n  status running\r\n  monitoring status  monitored" }
  it { should be_monitored_by('monit') }
  its(:command) { should eq "monit status" }
end

describe service('sshd') do
  let(:stdout) { "Process 'sshd'\r\n  status  not monitored\r\n  monitoring status  not monitored" }
  it { should_not be_monitored_by('monit') }
end

describe service('invalid-daemon') do
  it { should_not be_monitored_by('monit') }
end

describe service('unicorn') do
  it { should be_monitored_by('god') }
  its(:command) { should eq "god status unicorn" }
end

describe service('invalid-daemon') do
  it { should_not be_monitored_by('god') }
end

describe service('sshd') do
  it {
    expect {
      should be_monitored_by('not implemented')
    }.to raise_error(ArgumentError, %r/\A`be_monitored_by` matcher doesn\'t support/)
  }
end
