require 'spec_helper'

set :os, :family => 'linux'

describe kvm('ct01') do
  it { should exist }
end

describe kvm('ct01') do
  it { should be_running }
end

describe kvm('ct01') do
  it { should be_enabled }
end
