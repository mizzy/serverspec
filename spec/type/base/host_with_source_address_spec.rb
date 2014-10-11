require 'serverspec'

set :backend, :exec
set :os, :family => 'base'

describe host('127.0.0.1') do
  it { should be_reachable }
end

describe host('127.0.0.1'), 'with source address RFC5735 TEST-NET-1' do
  it { should_not be_reachable.with(:source_address => '192.0.2.1') }
end

describe host('127.0.0.1') do
  it { should be_reachable.with(:proto => "tcp", :port => 25) }
end

describe host('127.0.0.1'), 'with source address RFC5735 TEST-NET-1' do
  it { should_not be_reachable.with(:proto => "tcp", :port => 25, :source_address => '192.0.2.1') }
end
