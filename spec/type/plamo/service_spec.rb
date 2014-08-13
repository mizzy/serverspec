require 'spec_helper'

set :os, :family => 'plamo'

describe service('sshd') do
  it { should be_enabled }
end

