require 'spec_helper'

set :os, :family => 'darwin'

describe service('sshd') do
  it { should be_enabled }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
end

describe service('invalid-service') do
  it { should_not be_enabled.with_level(4) }
end

describe service('sshd') do
  it { should be_running }
end

describe service('invalid-service') do
  it { should_not be_running }
end

