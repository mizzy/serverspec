require 'spec_helper'

include SpecInfra::Helper::Solaris

describe ipnat do
  it { should have_rule 'map net1 192.168.0.0/24 -> 0.0.0.0/32' }
  its(:command) { should eq "ipnat -l 2> /dev/null | grep -- \\^map\\ net1\\ 192.168.0.0/24\\ -\\>\\ 0.0.0.0/32\\$" }
end
