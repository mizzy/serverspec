require 'spec_helper'

set :os, :family => 'openbsd'

describe service('sshd') do
  it { should be_enabled }
end

describe service('invalid-service') do
  it { should_not be_enabled }
end

describe service('sshd') do
  it { should be_running }
end

describe service('invalid-service') do
  it { should_not be_running }
end

