require 'spec_helper'

include Specinfra::Helper::RedHat

describe lxc('ct01') do
  it { should exist }
end

describe lxc('invalid-ct') do
  it { should_not exist }
end

describe lxc('ct01') do
  it { should be_running }
end

describe lxc('invalid-ct') do
  it { should_not be_running }
end

