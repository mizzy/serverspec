require 'spec_helper'

set :os, :family => 'linux'

describe linux_audit_system do
  let(:stdout) { out_auditctl1_1 }
  it { should be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_2 }
  it { should_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_1 }
  it { should be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_3 }
  it { should_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_4 }
  it { should_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_1 }
  it { should be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_2 }
  it { should_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_1 }
  it { should be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_3 }
  it { should_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_4 }
  it { should_not be_running }
end

describe linux_audit_system do
  let(:stdout) { '-a -w /etc/sysconfig -p wa -k test' }
  its(:rules) { should match %r!-w /etc/sysconfig.*-k test! }
end

describe linux_audit_system do
  let(:stdout) { 'test' }
  its(:rules) { should eq 'test' }
  its(:rules) { should match /es/ }
  its(:rules) { should_not match /ab/ }
end

# variants of auditctl -s output for different versions

def out_auditctl1_1
  "AUDIT_STATUS: enabled=1 flag=1 pid=881 rate_limit=0 backlog_limit=320 lost=0 backlog=0"
end

def out_auditctl1_2
  "AUDIT_STATUS: enabled=0 flag=1 pid=881 rate_limit=0 backlog_limit=320 lost=0 backlog=0"
end

def out_auditctl1_3
  "AUDIT_STATUS: enabled=1 flag=1 pid=0 rate_limit=0 backlog_limit=320 lost=0 backlog=0"
end

def out_auditctl1_4
  "AUDIT_STATUS: enabled=1 flag=1 pid= rate_limit=0 backlog_limit=320 lost=0 backlog=0"
end

def out_auditctl2_1
  <<EOS
enabled 1
failure 1
pid 5939
rate_limit 0
backlog_limit 64
lost 0
backlog 0
backlog_wait_time 60000
loginuid_immutable 0 unlocked
EOS
end

def out_auditctl2_2
  <<EOS
enabled 0
failure 1
pid 5939
rate_limit 0
backlog_limit 64
lost 0
backlog 0
backlog_wait_time 60000
loginuid_immutable 0 unlocked
EOS
end

def out_auditctl2_3
  <<EOS
enabled 0
failure 1
pid 0
rate_limit 0
backlog_limit 64
lost 0
backlog 0
backlog_wait_time 60000
loginuid_immutable 0 unlocked
EOS
end

def out_auditctl2_4
  <<EOS
enabled 0
failure 1
pid
rate_limit 0
backlog_limit 64
lost 0
backlog 0
backlog_wait_time 60000
loginuid_immutable 0 unlocked
EOS
end
