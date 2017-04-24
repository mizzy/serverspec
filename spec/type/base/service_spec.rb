require 'spec_helper'

set :os, :family => 'base'

describe service('sshd') do
  it { should be_running }
end

describe service('sshd') do
  let(:stdout) { "sshd is stopped\r\n" }
  it { should be_running }
end

describe service('sshd') do
  it { should be_running.under(:supervisor) }
end

describe service('sshd') do
  it { should be_running.under(:upstart) }
end

describe service('sshd') do
  it { should be_running.under(:daemontools) }
end

describe service('sshd') do
  it {
    expect {
      should be_running.under('not implemented')
    }.to raise_error(/is not implemented in Specinfra/)
  }
end

describe service('sshd') do
  let(:stdout) { "Process 'sshd'\r\n  status running\r\n  monitoring status  monitored" }
  it { should be_monitored_by(:monit) }
end

describe service('tinc') do
  let(:stdout) { "Process 'tinc-myvpn'\r\n  status running\r\n  monitoring status  monitored" }
  it { should be_monitored_by(:monit).with_name('tinc-myvpn') }
end

describe service('unicorn') do
  it { should be_monitored_by(:god) }
end

describe service('sshd') do
  it {
    expect {
      should be_monitored_by('not implemented')
    }.to raise_error(NotImplementedError)
  }
end
