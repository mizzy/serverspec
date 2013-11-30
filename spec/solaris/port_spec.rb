require 'spec_helper'

include SpecInfra::Helper::Solaris

describe port(80) do
  it { should be_listening }
  its(:command) { should eq %q!netstat -an 2> /dev/null | grep -- LISTEN | grep -- \\\\.80\\ ! }
end

describe port('invalid') do
  it { should_not be_listening }
end

describe port(80) do
  it { should be_listening.with("tcp") }
  its(:command) { should eq %q!netstat -an -P tcp 2> /dev/null | grep -- LISTEN | grep -- .\\*\\\\.80\\ ! }
end

describe port(123) do
  it { should be_listening.with("udp") }
  its(:command) { should eq %q!netstat -an -P udp 2> /dev/null | grep -- LISTEN | grep -- .\\*\\\\.123\\ ! }
end

describe port(80) do
  it { 
    expect {
      should be_listening.with('not implemented')
    }.to raise_error(ArgumentError, %r/\A`be_listening` matcher doesn\'t support/)
  }
end
