require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe port(80) do
  it { is_expected.to be_listening }
end

describe port(80) do
  it { is_expected.to be_listening.with("tcp") }
end

describe port(123) do
  it { is_expected.to be_listening.with("udp") }
end

describe port(80) do
  it { 
    expect {
      is_expected.to be_listening.with('not implemented')
    }.to raise_error(ArgumentError, %r/\A`be_listening` matcher doesn\'t support/)
  }
end
