require 'spec_helper'

set :os, :family => 'fedora', :release => 20

describe service('sshd') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
end

describe service('sshd') do
  it { should be_running }
end
