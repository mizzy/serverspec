shared_examples_for 'support routing table have_entry matcher' do
  describe 'routing table have_entry pattern #1' do
    before :all do
      RSpec.configure do |c|
          c.stdout = "192.168.100.0/24 dev eth1  proto kernel  scope link  src 192.168.100.10 \r\ndefault via 192.168.100.1 dev eth0 \r\n"
      end
    end

    context routing_table do
      it { should     have_entry( :destination => '192.168.100.0/24' ) }
      it { should_not have_entry( :destination => '192.168.100.100/24' ) }

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
  end

  describe 'routing table have_entry pattern #2' do
    before :all do
      RSpec.configure do |c|
          c.stdout = "192.168.200.0/24 via 192.168.200.1 dev eth0 \r\ndefault via 192.168.100.1 dev eth0 \r\n"
      end
    end

    context routing_table do
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
  end

  describe 'routing table have_entry #3' do
    before :all do
      RSpec.configure do |c|
          c.stdout = "default via 10.0.2.2 dev eth0 \r\n"
      end
    end

    context routing_table do
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
  end
end
