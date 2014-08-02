require 'spec_helper'

set :os, {:family => 'aix'}

describe file('/tmp') do
  it { should be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_executable.by_user('mail') }
end

describe file('/etc/passwd') do
  it 'be_mode is not implemented' do
    expect {
      should be_mode 644
    }.to raise_exception
  end
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
end
