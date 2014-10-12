require 'spec_helper'

property[:os] = nil
set :os, {:family => 'linux'}

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
