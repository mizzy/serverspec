require 'spec_helper'

set :os, :family => 'freebsd'

describe service('sshd') do
  it { should be_enabled }
end

