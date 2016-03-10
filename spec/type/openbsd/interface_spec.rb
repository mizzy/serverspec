require 'spec_helper'

set :os, :family => 'openbsd'

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { should eq 1000 }
end

describe interface('eth0') do
  it { should have_ipv4_address("192.168.10.10") }
end

describe interface('eth0') do
  it { should have_ipv4_address("192.168.10.10/24") }
end

describe interface('eth1') do
  let(:stdout) { "1.2.3.4/1\r\n" }
  its(:ipv4_address) { should match(/^[\d.]+\/\d+$/) }
end

describe interface('eth1') do
  let(:stdout) { "2001:db8::1234/1\r\n" }
  its(:ipv6_address) { should match(/^[a-f\d:]+\/\d+$/i) }
end

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { should_not eq 100 }
end
