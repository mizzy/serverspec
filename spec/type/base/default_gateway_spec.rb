require 'spec_helper'

set :os, :family => 'base'

describe default_gateway do
  let(:stdout) { "default via 192.168.1.1 dev eth1 \r\n" }
  its(:ipaddress) { is_expected.to eq '192.168.1.1' }
  its(:interface) { is_expected.to eq 'eth1' }
  its(:ipaddress) { is_expected.to_not eq '192.168.1.2' }
  its(:interface) { is_expected.to_not eq 'eth0'        }
end
