require 'spec_helper'

set :os, :family => 'openbsd'

describe service('sshd') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_running }
end


