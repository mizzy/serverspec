require 'spec_helper'

set :os, :family => 'linux'

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { should eq 1000 }
end

describe interface('eth0') do
  let(:stdout) { '1500' }
  its(:mtu) { should eq 1500 }
end

describe interface('eth0') do
  it { should have_ipv4_address('192.168.10.10') }
end

describe interface('eth0') do
  it { should have_ipv4_address('192.168.10.10/24') }
end

describe interface('eth0') do
  it { should have_ipv6_address('2001:0db8:bd05:01d2:288a:1fc0:0001:10ee') }
end

describe interface('eth1') do
  let(:stdout) { "1.2.3.4/1\r\n" }
  its(:ipv4_address) { should match(/^[\d.]+\/\d+$/) }
end

describe interface('eth1') do
  let(:stdout) { "2001:db8::1234/1\r\n" }
  its(:ipv6_address) { should match(/^[a-f\d:]+\/\d+$/i) }
end

describe interface('eth0') do
  let(:stdout) { 'up' }
  it { should be_up }
end

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { should_not eq 100 }
end

describe interface('invalid-interface') do
  let(:stdout) { '9001' }
  its(:mtu) { should_not eq 1500 }
end
