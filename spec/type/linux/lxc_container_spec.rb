require 'spec_helper'

set :os, :family => 'linux'

describe lxc('ct01') do
  it { should exist }
end

describe lxc('ct01') do
  it { should be_running }
end

