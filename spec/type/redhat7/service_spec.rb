require 'spec_helper'

set :os, :family => 'redhat', :release => 7

describe service('sshd') do
  it { is_expected.to be_enabled }
  it { is_expected.to be_running }
end

