require 'spec_helper'

set :os, :family => 'ubuntu'

describe service('sshd') do
  it { is_expected.to be_running }
end
