require 'spec_helper'

RSpec.configure do |c|
  c.os      = 'Solaris'
  c.backend = 'Exec'
end

describe ipfilter do
  it { should have_rule 'pass in quick on lo0 all' }
  its(:command) { should eq "ipfstat -io 2> /dev/null | grep -- pass\\ in\\ quick\\ on\\ lo0\\ all" }
end
