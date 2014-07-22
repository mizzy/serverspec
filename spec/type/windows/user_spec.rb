require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('user').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::User) }
end

describe user('test.user') do
  it { should exist }
end

describe user('test.domain\test.user') do
  it { should exist }
end

describe user('invalid-user') do
  it { should_not exist }
end

describe user('test.user') do
  it { should belong_to_group 'test.group' }
end

describe user('test.user.domain\test.user') do
  it { should belong_to_group 'test.group.domain\test.group' }
end

describe user('test.user') do
  it { should_not belong_to_group 'invalid-group' }
end

describe user('test.user') do
  it "should raise error if command is not supported" do 
    {
      :have_uid => [nil],
      :have_login_shell => [nil],
      :have_authorized_key => [nil],
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error Specinfra::Command::Base::NotImplementedError
    end
  end
end
