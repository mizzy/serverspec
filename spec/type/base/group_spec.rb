require 'spec_helper'

set :os, :family => 'base'

describe commands.command_class('group') do
  it { should be_an_instance_of(Specinfra::Command::Base::Group) }
end

describe group('root') do
  it { should exist }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('root') do
  it { should have_gid 0 }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
