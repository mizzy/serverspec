require 'spec_helper'

include Serverspec::Helper::Solaris

describe ipfilter do
  it { should have_rule 'pass in quick on lo0 all' }
end
