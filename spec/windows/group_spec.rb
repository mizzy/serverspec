require 'spec_helper'

include Serverspec::Helper::Cmd
RSpec.configure do |c|
  c.os = 'Windows'
end

describe group('test.group') do
  it { should exist }
  its(:command) { should eq "(FindGroup -groupName 'test.group') -ne $null" }
end

describe group('test.domain\test.group') do
  it { should exist }
  its(:command) { should eq "(FindGroup -groupName 'test.group' -domain 'test.domain') -ne $null" }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('test.group') do
  it "should raise error if command is not supported" do 
    {
      :have_gid => [nil],
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error Serverspec::Commands::Windows::NotSupportedError
    end
  end
end

