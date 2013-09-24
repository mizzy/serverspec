require 'spec_helper'

include Serverspec::Helper::RedHat

describe host('127.0.0.1') do
  it { should be_resolvable }
  its(:command) { should eq "getent hosts 127.0.0.1" }
end

describe host('invalid-name') do
  it { should_not be_resolvable }
end

describe host('127.0.0.1') do
  it { should be_resolvable.by('hosts') }
  its(:command) { should eq "grep -w -- 127.0.0.1 /etc/hosts" }
end

describe host('invalid-name') do
  it { should_not be_resolvable.by('hosts') }
end

describe host('127.0.0.1') do
  it { should be_resolvable.by('dns') }
  its(:command) { should eq "nslookup -timeout=1 127.0.0.1" }
end

describe host('invalid-name') do
  it { should_not be_resolvable.by('dns') }
end

describe host('127.0.0.1') do
  it { should be_reachable }
  its(:command) { should eq "ping -n 127.0.0.1 -w 5 -c 2" }
end

describe host('invalid-host') do
  it { should_not be_reachable }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "icmp", :timeout=> 1) }
  its(:command) { should eq "ping -n 127.0.0.1 -w 1 -c 2" }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "tcp", :port => 22, :timeout=> 1) }
  its(:command) { should eq "nc -vvvvzt 127.0.0.1 22 -w 1" }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
  its(:command) { should eq "nc -vvvvzu 127.0.0.1 53 -w 1" }
end

describe host('invalid-host') do
  it { should_not be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
end
