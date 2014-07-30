require 'spec_helper'

set :os, :family => 'redhat'

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
