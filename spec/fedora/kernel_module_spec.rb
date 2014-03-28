require 'spec_helper'

include SpecInfra::Helper::Fedora

describe kernel_module('lp') do
  it { should be_loaded }
  its(:command) { should eq "lsmod | grep ^lp" }
end

describe kernel_module('invalid-module') do
  it { should_not be_loaded }
end
