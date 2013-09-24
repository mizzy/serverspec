require 'spec_helper'

RSpec.configure do |c|
  c.os = 'SmartOS'
end

## SmartOS
describe 'check_installed' do
  subject { commands.check_installed('httpd') }
  it { should eq '/opt/local/bin/pkgin list 2> /dev/null | grep -qw ^httpd' }
end

## SmartOS
describe 'check_installed' do
  subject { commands.check_installed('httpd', '2.2') }
  it { should eq '/opt/local/bin/pkgin list 2> /dev/null | grep -qw ^httpd-2.2' }
end

describe 'check_zfs' do
  context 'check without properties' do
    subject { commands.check_zfs('rpool') }
    it { should eq "zfs list -H rpool" }
  end

  context 'check with a property' do
    subject { commands.check_zfs('rpool', { 'mountpoint' => '/rpool' }) }
    it { should eq "zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
  end

  context 'check with multiple properties' do
    subject { commands.check_zfs('rpool', { 'mountpoint'  => '/rpool', 'compression' => 'off' }) }
    it { should eq "zfs list -H -o compression rpool | grep -- \\^off\\$ && zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
  end
end

describe 'check_ip_filter_rule' do
  subject { commands.check_ipfilter_rule('pass in quick on lo0 all') }
  it { should eq "ipfstat -io 2> /dev/null | grep -- pass\\ in\\ quick\\ on\\ lo0\\ all" }
end

describe 'check_ipnat_rule' do
  subject { commands.check_ipnat_rule('map net1 192.168.0.0/24 -> 0.0.0.0/32') }
  it { should eq "ipnat -l 2> /dev/null | grep -- \\^map\\ net1\\ 192.168.0.0/24\\ -\\>\\ 0.0.0.0/32\\$" }
end

describe 'check_svcprop' do
  subject { commands.check_svcprop('svc:/network/http:apache22', 'httpd/enable_64bit','false') }
  it { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$" }
end

describe 'check_svcprops' do
  subject {
    commands.check_svcprops('svc:/network/http:apache22', {
      'httpd/enable_64bit' => 'false',
      'httpd/server_type'  => 'worker',
    })
  }
  it { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$ && svcprop -p httpd/server_type svc:/network/http:apache22 | grep -- \\^worker\\$" }
end
