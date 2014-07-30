require 'spec_helper'

set :os, :family => 'arch'

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

