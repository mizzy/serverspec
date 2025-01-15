require 'spec_helper'

set :os, :family => 'linux'

describe linux_audit_system do
  let(:stdout) { out_auditctl1_1 }
  it { is_expected.to be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_2 }
  it { is_expected.to_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_1 }
  it { is_expected.to be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_3 }
  it { is_expected.to_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl1_4 }
  it { is_expected.to_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_1 }
  it { is_expected.to be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_2 }
  it { is_expected.to_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_1 }
  it { is_expected.to be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_3 }
  it { is_expected.to_not be_running }
end

describe linux_audit_system do
  let(:stdout) { out_auditctl2_4 }
  it { is_expected.to_not be_running }
end

describe linux_audit_system do
  let(:stdout) { '-a -w /etc/sysconfig -p wa -k test' }
  its(:rules) { is_expected.to match %r!-w /etc/sysconfig.*-k test! }
end

describe linux_audit_system do
  let(:stdout) { 'test' }
  its(:rules) { is_expected.to eq 'test' }
  its(:rules) { is_expected.to match /es/ }
  its(:rules) { is_expected.to_not match /ab/ }
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
