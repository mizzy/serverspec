require 'spec_helper'

set :os, :family => 'arch'

describe file('/tmp') do
  it { is_expected.to be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { is_expected.to be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { is_expected.to be_executable.by_user('mail') }
end
