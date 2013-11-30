require 'spec_helper'

include SpecInfra::Helper::Solaris11

describe ipfilter do
  it { should have_rule 'pass in quick on lo0 all' }
  its(:command) { should eq "ipfstat -io 2> /dev/null | grep -- pass\\ in\\ quick\\ on\\ lo0\\ all" }
end
