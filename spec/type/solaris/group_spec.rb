require 'spec_helper'

set :os, :family => 'solaris'

describe commands.command_class('group').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::Base::Group) }
end

describe group('root') do
  it { should have_gid 0 }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
