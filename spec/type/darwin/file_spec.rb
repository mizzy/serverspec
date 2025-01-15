require 'spec_helper'

set :os, :family => 'darwin'

describe file('/tmp') do
  it { is_expected.to be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { is_expected.to be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { is_expected.to be_executable.by_user('mail') }
end

describe file('/etc/services') do
  let(:stdout) { "35435ea447c19f0ea5ef971837ab9ced\n" }
  its(:md5sum) { is_expected.to eq '35435ea447c19f0ea5ef971837ab9ced' }
end

describe file('/etc/services') do
  let(:stdout)  {"0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a" }
  its(:sha256sum) { is_expected.to eq '0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a' }
end

describe file('/etc/pam.d/system-auth') do
  it { is_expected.to be_linked_to '/etc/pam.d/system-auth-ac' }
end

describe file('/etc/passwd') do
  it { is_expected.to be_mode 644 }
end

describe file('/etc/passwd') do
  it { is_expected.to be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { is_expected.to be_grouped_into 'root' }
end
