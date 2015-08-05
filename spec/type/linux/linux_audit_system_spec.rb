require 'spec_helper'

set :os, :family => 'linux'

describe linux_audit_system do
  let(:stdout) { '1' }
  it { should be_enabled }
end

describe linux_audit_system do
  let(:stdout) { '0' }
  it { should_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { '' }
  it { should_not be_enabled }
end

describe linux_audit_system do
  let(:stdout) { '12345' }
  it { should be_running }
end

describe linux_audit_system do
  let(:stdout) { '0' }
  it { should_not be_running }
end

describe linux_audit_system do
  let(:stdout) { '' }
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
