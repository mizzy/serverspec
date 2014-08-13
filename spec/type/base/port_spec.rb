require 'spec_helper'

set :os, :family => 'base'

describe port(80) do
  it { should be_listening }
end

describe port(80) do
  it { should be_listening.with('tcp') }
end

describe port(80) do
  it do
      expect {
        should be_listening.with('not implemented')
      }.to raise_error(ArgumentError, %r/\A`be_listening` matcher doesn\'t support/)
    end
end

describe port(80) do
  it { should be_listening.on('127.0.0.1') }
end

describe port(80) do
  it do
    expect{ should be_listening.on('') }.to raise_error(ArgumentError)
  end
end

describe port(53) do
  it { should be_listening.with('udp') }
end

