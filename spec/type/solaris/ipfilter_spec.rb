require 'spec_helper'

set :os, :family => 'solaris'

describe commands.command_class('ipfilter').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::Base::Ipfilter) }
end

describe ipfilter do
  it { should have_rule 'pass in quick on lo0 all' }
end
