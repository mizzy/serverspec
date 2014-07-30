require 'spec_helper'

set :os, :family => 'redhat', :release => 7

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

