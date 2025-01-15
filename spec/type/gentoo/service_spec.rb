require 'spec_helper'

set :os, :family => 'gentoo'

describe service('sshd') do
  it { is_expected.to be_enabled }
end

describe service('sshd') do
  it { is_expected.to be_running }
end

