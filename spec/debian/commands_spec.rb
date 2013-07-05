require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec commands of Debian family' do
  it_behaves_like 'support command check_running_under_supervisor', 'httpd'

  it_behaves_like 'support command check_running_under_upstart', 'monit'

  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'

  it_behaves_like 'support command check_process', 'httpd'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq "ls /etc/rc3.d/ | grep -- httpd || grep 'start on' /etc/init/httpd.conf" }
end

describe 'check_enabled with run level 5' do
  subject { commands.check_enabled('httpd', 5) }
  it { should eq "ls /etc/rc5.d/ | grep -- httpd || grep 'start on' /etc/init/httpd.conf" }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq "service httpd status | grep 'running'" }
end
