require 'spec_helper'

set :os, :family => 'linux'

describe kvm('ct01') do
  it { is_expected.to exist }
end

describe kvm('ct01') do
  it { is_expected.to be_running }
end

describe kvm('ct01') do
  it { is_expected.to be_enabled }
end
