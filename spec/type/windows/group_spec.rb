require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe group('test.group') do
  it { is_expected.to exist }
end

describe group('test.domain\test.group') do
  it { is_expected.to exist }
end

describe group('test.group') do
  it "should raise error if command is not supported" do 
    {
      :have_gid => [nil],
    }.each do |method, args|
      expect { is_expected.to self.send(method, *args) }.to raise_error(NotImplementedError)
    end
  end
end
