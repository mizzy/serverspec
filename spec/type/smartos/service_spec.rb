require 'spec_helper'

set :os, :family => 'smartos'

describe service('sshd') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_running }
end

describe service('sshd') do
  it { should have_property :foo => 'bar' }
end

