require 'spec_helper'

set :os, :family => 'plamo'

describe service('sshd') do
  it { is_expected.to be_enabled }
end

