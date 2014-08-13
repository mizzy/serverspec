require 'spec_helper'

set :os, :family => 'gentoo'

describe service('sshd') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_running }
end

