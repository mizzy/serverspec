require 'spec_helper'

set :os, :family => 'linux'

describe lxc('ct01') do
  it { is_expected.to exist }
end

describe lxc('ct01') do
  it { is_expected.to be_running }
end

