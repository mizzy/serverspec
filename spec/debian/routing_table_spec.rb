require 'spec_helper'

include Serverspec::Helper::Debian

describe routing_table do
  let(:stdout) { "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\ndefault via 192.168.100.1 dev eth0 \r\n" }
  it { should have_entry( :destination => '192.168.100.0/24' ) }
  its(:command) { should eq "ip route | grep -E '^192.168.100.0/24 |^default '" }
end

describe routing_table do
  let(:stdout) { "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\ndefault via 192.168.100.1 dev eth0 \r\n" }
  it { should_not have_entry( :destination => '192.168.100.100/24' ) }
  its(:command) { should eq "ip route | grep -E '^192.168.100.100/24 |^default '" }
end

describe routing_table do
  let(:stdout) { "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\ndefault via 192.168.100.1 dev eth0 \r\n" }
  it do
    should have_entry(
      :destination => '192.168.100.0/24',
      :gateway     => '192.168.100.1'
    )
  end

  it do
    should have_entry(
      :destination => '192.168.100.0/24',
      :gateway     => '192.168.100.1',
      :interface   => 'eth1'
    )
  end

  it do
    should_not have_entry(
      :gateway   => '192.168.100.1',
      :interface => 'eth1'
    )
  end

  it do
    should_not have_entry(
      :destination => '192.168.100.0/32',
      :gateway     => '192.168.100.1',
      :interface   => 'eth1'
    )
  end
end

describe routing_table do
  let(:stdout) { "192.168.200.0/24 via 192.168.200.1 dev eth0 \r\ndefault via 192.168.100.1 dev eth0 \r\n" }
  it { should     have_entry( :destination => '192.168.200.0/24' ) }
  it { should_not have_entry( :destination => '192.168.200.200/24' ) }

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

  it do
    should_not have_entry(
      :gateway     => '192.168.200.1',
      :interface   => 'eth0'
    )
  end

  it do
    should_not have_entry(
      :destination => '192.168.200.0/32',
      :gateway     => '192.168.200.1',
      :interface   => 'eth0'
    )
  end
end

describe routing_table do
  let(:stdout) { "default via 10.0.2.2 dev eth0 \r\n" }
  it { should     have_entry( :destination => 'default' ) }
  it { should_not have_entry( :destination => 'defaulth' ) }

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

  it do
    should_not have_entry(
      :gateway     => '10.0.2.2',
      :interface   => 'eth0'
    )
  end

  it do
    should_not have_entry(
      :destination => 'default',
      :gateway     => '10.0.2.1',
      :interface   => 'eth0'
    )
  end
end
