require 'spec_helper'

set :os, :family => 'solaris'

describe commands.command_class('ipfilter').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::Base::Ipfilter) }
end

describe ipnat do
  it { should have_rule 'map net1 192.168.0.0/24 -> 0.0.0.0/32' }
end
