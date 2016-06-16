require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe user('test.user') do
  it { should exist }
end

describe user('test.domain\test.user') do
  it { should exist }
end

describe user('test.user') do
  it { should belong_to_group 'test.group' }
end

describe user('test.user.domain\test.user') do
  it { should belong_to_group 'test.group.domain\test.group' }
end

describe user('test.user') do
  it "should raise error if command is not supported" do 
    {
      :have_uid => [nil],
      :have_login_shell => [nil],
      :have_authorized_key => [nil],
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error(NotImplementedError)
    end
  end
end
