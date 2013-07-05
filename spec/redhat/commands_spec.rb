require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec commands of Red Hat' do
  it_behaves_like 'support command check_running_under_supervisor', 'httpd'

  it_behaves_like 'support command check_running_under_upstart', 'monit'

  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'

  it_behaves_like 'support command check_process', 'httpd'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq 'chkconfig --list httpd | grep 3:on' }
end

describe 'check_enabled with level 4' do
  subject { commands.check_enabled('httpd', 4) }
  it { should eq 'chkconfig --list httpd | grep 4:on' }
end

describe 'check_yumrepo' do
  subject { commands.check_yumrepo('epel') }
  it { should eq 'yum repolist all -C | grep ^epel' }
end

describe 'check_yumrepo_enabled' do
  subject { commands.check_yumrepo_enabled('epel') }
  it { should eq 'yum repolist all -C | grep ^epel | grep enabled' }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq 'service httpd status' }
end
