require 'spec_helper'

set :os, :family => 'freebsd'

describe file('/etc/passwd') do
  it { should be_mode 644 }
end

describe file('/etc/passwd') do
  it { should_not be_mode 'invalid' }
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { should_not be_owned_by 'invalid-owner' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
end

describe file('/etc/passwd') do
  it { should_not be_grouped_into 'invalid-group' }
end

describe file('/sbin/nologin') do
  it { should be_linked_to '/usr/sbin/nologin' }
end

describe file('dummy-link') do
  it { should_not be_linked_to '/invalid/target' }
end

describe file('/etc/passwd') do
  let(:stdout) { Time.now.to_i.to_s }
  its(:mtime) { should > DateTime.now - 1 }
end

describe file('/etc/passwod') do
  let(:stdout) { 100.to_s }
  its(:size) { should > 0 }
end
