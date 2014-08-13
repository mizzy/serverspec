require 'spec_helper'

set :os, :family => 'ubuntu'

describe service('sshd') do
  it { should be_running }
end
