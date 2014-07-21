require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe commands.command_class('group').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::V10::Group) }
end

describe group('root') do
  it { should exist }
end

describe group('invalid-group') do
  it { should_not exist }
end

