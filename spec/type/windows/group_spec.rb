require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('group').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::Group) }
end

describe group('test.group') do
  it { should exist }
end

describe group('test.domain\test.group') do
  it { should exist }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('test.group') do
  it "should raise error if command is not supported" do 
    {
      :have_gid => [nil],
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error Specinfra::Command::Base::NotImplementedError
    end
  end
end
