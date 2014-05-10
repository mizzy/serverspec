require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe port(80) do
  it { should be_listening }
  its(:command) { should eq 'IsPortListening -portNumber 80' }
end

describe port('invalid') do
  it { should_not be_listening }
end

describe port(80) do
  it { should be_listening.with("tcp") }
  its(:command) { should eq "IsPortListening -portNumber 80 -protocol 'tcp'" }
end

describe port(123) do
  it { should be_listening.with("udp") }
  its(:command) { should eq "IsPortListening -portNumber 123 -protocol 'udp'" }
end

describe port(80) do
  it { 
    expect {
      should be_listening.with('not implemented')
    }.to raise_error(ArgumentError, %r/\A`be_listening` matcher doesn\'t support/)
  }
end
