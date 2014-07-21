require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe commands.command_class('user').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::V10::User) }
end

describe user('root') do
  it { should have_authorized_key 'XXXXXXXXXXXXXXX' }
end

describe user('root') do
  it { should_not have_authorized_key 'invalid-key' }
end

