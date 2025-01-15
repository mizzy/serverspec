require 'spec_helper'

set :os, :family => 'arch'

describe service('sshd') do
  it { is_expected.to be_enabled }
  it { is_expected.to be_running }
end

