require 'spec_helper'

set :os, :family => 'linux'

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { should eq 1000 }
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

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { should_not eq 100 }
end
