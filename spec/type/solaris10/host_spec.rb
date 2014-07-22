require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe commands.command_class('host').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::V10::Host) }
end

describe host('127.0.0.1') do
  it { should be_reachable }
end

describe host('invalid-host') do
  it { should_not be_reachable }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "icmp", :timeout=> 1) }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "tcp", :port => 22, :timeout=> 1) }
end

