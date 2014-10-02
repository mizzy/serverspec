require 'spec_helper'

include SpecInfra::Helper::Plamo

describe selinux_module('xen') do
  it { should be_installed }
  its(:command) { should eq "semodule -l | grep -i -- ^xen" }
end

describe selinux_module('xen') do
  it { should be_enabled }
  its(:command) { should eq "semodule -l | grep -i -- ^xen | grep -vi -- Disabled$" }
end
