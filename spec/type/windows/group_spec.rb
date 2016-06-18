require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe group('test.group') do
  it { should exist }
end

describe group('test.domain\test.group') do
  it { should exist }
end

describe group('test.group') do
  it "should raise error if command is not supported" do 
    {
      :have_gid => [nil],
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error(NotImplementedError)
    end
  end
end
