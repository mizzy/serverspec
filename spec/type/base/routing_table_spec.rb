require 'spec_helper'

set :os, :family => 'base'

describe routing_table do
  let(:stdout) { "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\n" }
  it { should have_entry( :destination => '192.168.100.0/24' ) }
end

describe routing_table do
  let(:exit_status) { 1 }
  it { should_not have_entry( :destination => '192.168.100.100/24' ) }
end

describe routing_table do
  let(:stdout) { "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\n" }
  it do
    should have_entry(
      :destination => '192.168.100.0/24',
      :interface   => 'eth1'
    )
  end
end

describe routing_table do
  let(:stdout) { "192.168.200.0/24 via 192.168.200.1 dev eth0 \r\n" }
  it { should have_entry( :destination => '192.168.200.0/24' ) }

  it do
    should have_entry(
      :destination => '192.168.200.0/24',
      :gateway     => '192.168.200.1'
    )
  end

  it do
    should have_entry(
      :destination => '192.168.200.0/24',
      :gateway     => '192.168.200.1',
      :interface   => 'eth0'
    )
  end
end

describe routing_table do
  let(:stdout) { "default via 10.0.2.2 dev eth0 \r\n" }
  it { should     have_entry( :destination => 'default' ) }

  it do
    should have_entry(
      :destination => 'default',
      :gateway     => '10.0.2.2'
    )
  end

  it do
    should have_entry(
      :destination => 'default',
      :gateway     => '10.0.2.2',
      :interface   => 'eth0'
    )
  end
end
