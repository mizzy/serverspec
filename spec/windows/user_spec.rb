require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe user('test.user') do
  it { should exist }
  its(:command) { should eq "(FindUser -userName 'test.user') -ne $null" }
end

describe user('test.domain\test.user') do
  it { should exist }
  its(:command) { should eq "(FindUser -userName 'test.user' -domain 'test.domain') -ne $null" }
end

describe user('invalid-user') do
  it { should_not exist }
end

describe user('test.user') do
  it { should belong_to_group 'test.group' }
  its(:command) { should eq "(FindUserGroup -userName 'test.user' -groupName 'test.group') -ne $null" }
end

describe user('test.user.domain\test.user') do
  it { should belong_to_group 'test.group.domain\test.group' }
  its(:command) { should eq "(FindUserGroup -userName 'test.user' -userDomain 'test.user.domain' -groupName 'test.group' -groupDomain 'test.group.domain') -ne $null" }
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
      expect { should self.send(method, *args) }.to raise_error SpecInfra::Command::Windows::NotSupportedError
    end
  end
end
