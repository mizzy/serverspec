require 'spec_helper'

set :os, :family => 'solaris'

describe ipfilter do
  it { is_expected.to have_rule 'pass in quick on lo0 all' }
end
