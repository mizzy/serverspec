require 'spec_helper'

RSpec.configure do |c|
  c.os = 'Debian'
end

describe kernel_module('lp') do
  it { should be_loaded }
  its(:command) { should eq "lsmod | grep ^lp" }
end

describe kernel_module('invalid-module') do
  it { should_not be_loaded }
end
