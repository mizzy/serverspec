require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec commands of Debian family' do
  it_behaves_like 'support command check_user', 'root'
  it_behaves_like 'support command check_user', 'wheel'

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'

  it_behaves_like 'support command check_running_under_upstart', 'monit'

  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'

  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_belonging_group', 'root', 'wheel'

  it_behaves_like 'support command check_uid', 'root', 0
  it_behaves_like 'support command check_gid', 'root', 0

  it_behaves_like 'support command check_login_shell', 'root', '/bin/bash'
  it_behaves_like 'support command check_home_directory', 'root', '/root'

  it_behaves_like 'support command check_authorized_key'
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
