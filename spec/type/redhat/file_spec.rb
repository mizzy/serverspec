require 'spec_helper'

set :os, :family => 'redhat'

describe file('/tmp') do
  it { should be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { should_not be_readable.by_user('invalid-user') }
end

describe file('/tmp') do
  it { should be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { should_not be_writable.by_user('invalid-user') }
end


describe file('/tmp') do
  it { should be_executable.by_user('mail') }
end

describe file('/tmp') do
  it { should_not be_executable.by_user('invalid-user') }
end

describe file('/tmp') do
  it { should be_immutable }
end
