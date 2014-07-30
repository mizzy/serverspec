require 'spec_helper'

set :os, :family => 'ubuntu'

describe service('sshd') do
  it { should be_running }
end

describe service('invalid-service') do
  it { should_not be_running }
end
