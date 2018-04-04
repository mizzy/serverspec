require 'spec_helper'

set :os, :family => 'linux'

describe lxc_container('ct01') do
  it { should exist }
end

describe lxc_container('ct01') do
  it { should be_running }
end
