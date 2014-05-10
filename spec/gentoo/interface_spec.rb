require 'spec_helper'

include SpecInfra::Helper::Gentoo

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { should eq 1000 }
  its(:command) { should eq "ethtool eth0 | grep Speed | gawk '{print gensub(/Speed: ([0-9]+)Mb\\/s/,\"\\\\1\",\"\")}'" }
end

describe interface('eth0') do
  it { should have_ipv4_address("192.168.10.10") }
  its(:command) { should eq "ip addr show eth0 | grep 'inet 192\\.168\\.10\\.10/'" }
end

describe interface('eth0') do
  it { should have_ipv4_address("192.168.10.10/24") }
  its(:command) { should eq "ip addr show eth0 | grep 'inet 192\\.168\\.10\\.10/24 '" }
end

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { should_not eq 100 }
end
