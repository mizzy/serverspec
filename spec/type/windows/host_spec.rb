require 'spec_helper'

set :backend, :cmd
set :os, :family => 'windows'

describe host('127.0.0.1') do
  it { is_expected.to be_resolvable }
end

describe host('127.0.0.1') do
  it { is_expected.to be_resolvable.by('hosts') }
end

describe host('127.0.0.1') do
  it { is_expected.to be_resolvable.by('dns') }
end

describe host('127.0.0.1') do
  it { is_expected.to be_reachable }
end

describe host('127.0.0.1') do
  it { is_expected.to be_reachable.with(:proto => "icmp", :timeout=> 1) }
end

describe host('127.0.0.1') do
  it { is_expected.to be_reachable.with(:proto => "tcp", :port => 22, :timeout=> 1) }
end

describe host('127.0.0.1') do
  it { is_expected.to be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
end
