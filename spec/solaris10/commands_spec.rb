require 'spec_helper'

include Serverspec::Helper::Solaris10

describe 'Serverspec commands of Solaris family' do
  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'
  it_behaves_like 'support command check_process', 'httpd'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq "svcs -l httpd 2> /dev/null | egrep '^enabled *true$'" }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq "svcs -l httpd status 2> /dev/null | egrep '^state *online$'" }
end

describe 'check_belonging_group' do
  subject { commands.check_belonging_group('root', 'wheel') }
  it { should eq "id -Gn root | grep -- wheel" }
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
