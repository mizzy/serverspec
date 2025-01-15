require 'spec_helper'

set :os, :family => 'openbsd'

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { is_expected.to eq 1000 }
end

describe interface('eth0') do
  it { is_expected.to have_ipv4_address("192.168.10.10") }
end

describe interface('eth0') do
  it { is_expected.to have_ipv4_address("192.168.10.10/24") }
end

describe interface('eth1') do
  let(:stdout) { "1.2.3.4/1\r\n" }
  its(:ipv4_address) { is_expected.to match(/^[\d.]+\/\d+$/) }
end

describe interface('eth1') do
  let(:stdout) { "2001:db8::1234/1\r\n" }
  its(:ipv6_address) { is_expected.to match(/^[a-f\d:]+\/\d+$/i) }
end

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { is_expected.to_not eq 100 }
end
