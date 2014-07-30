require 'spec_helper'

set :os, :family => 'solaris'

describe ipfilter do
  it { should have_rule 'pass in quick on lo0 all' }
end
