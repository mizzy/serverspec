require 'spec_helper'

set :os, {:family => 'linux'}

property[:os_by_host] = nil

describe file('/tmp') do
  it { should be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_executable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_immutable }
end
