require 'spec_helper'

set :os, :family => 'freebsd'

describe service('sshd') do
  it { is_expected.to be_enabled }
end

