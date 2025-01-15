require 'spec_helper'

set :os, :family => 'nixos'

describe service('sshd') do
  it { is_expected.to be_enabled }
  it { is_expected.to be_running }
end

