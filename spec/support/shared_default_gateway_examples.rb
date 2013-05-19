shared_examples_for 'support default gateway matcher' do
  describe 'default_gateway' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "default via 192.168.1.1 dev eth1 \r\n"
      end
    end

    describe default_gateway do
      its(:ipaddress) { should eq '192.168.1.1' }
      its(:interface) { should eq 'eth1'        }

      its(:ipaddress) { should_not eq '192.168.1.2' }
      its(:interface) { should_not eq 'eth0'        }
    end
  end
end
