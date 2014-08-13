require 'spec_helper'

set :os, :family => 'redhat'

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
