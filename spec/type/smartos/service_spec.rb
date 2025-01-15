require 'spec_helper'

set :os, :family => 'smartos'

describe service('sshd') do
  it { is_expected.to be_enabled }
end

describe service('sshd') do
  it { is_expected.to be_running }
end

describe service('sshd') do
  it { is_expected.to have_property :foo => 'bar' }
end

