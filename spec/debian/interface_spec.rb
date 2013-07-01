require 'spec_helper'

include Serverspec::Helper::Debian

describe interface('eth0') do
  let(:stdout) { '1000' }
  its(:speed) { should eq 1000 }
  its(:command) { should eq "ethtool eth0 | grep Speed | gawk '{print gensub(/Speed: ([0-9]+)Mb\\/s/,\"\\\\1\",\"\")}'" }
end

describe interface('invalid-interface') do
  let(:stdout) { '1000' }
  its(:speed) { should_not eq 100 }
end
