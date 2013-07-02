require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec commands of Red Hat' do
  it_behaves_like 'support command check_file', '/etc/passwd'
  it_behaves_like 'support command check_directory', '/var/log'
  it_behaves_like 'support command check_socket', '/var/run/unicorn.sock'

  it_behaves_like 'support command check_mounted', '/'

  it_behaves_like 'support command check_user', 'root'
  it_behaves_like 'support command check_user', 'wheel'

  it_behaves_like 'support command check_file_md5checksum', '/etc/passewd', '96c8c50f81a29965f7af6de371ab4250'

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'

  it_behaves_like 'support command check_running_under_upstart', 'monit'

  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'

  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_file_contain', '/etc/passwd', 'root'
  it_behaves_like 'support command check_file_contain_within'

  it_behaves_like 'support command check_mode', '/etc/sudoers', 440
  it_behaves_like 'support command check_owner', '/etc/sudoers', 'root'
  it_behaves_like 'support command check_grouped', '/etc/sudoers', 'wheel'

  it_behaves_like 'support command check_link', '/etc/system-release', '/etc/redhat-release'

  it_behaves_like 'support command check_belonging_group', 'root', 'wheel'

  it_behaves_like 'support command check_uid', 'root', 0
  it_behaves_like 'support command check_gid', 'root', 0

  it_behaves_like 'support command check_login_shell', 'root', '/bin/bash'
  it_behaves_like 'support command check_home_directory', 'root', '/root'

  it_behaves_like 'support command check_authorized_key'

  it_behaves_like 'support command check_selinux'

  it_behaves_like 'support command get_mode'

  it_behaves_like 'support command check_kernel_module_loaded', 'lp'
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

describe 'check_access_by_user' do
  context 'read access' do
    subject {commands.check_access_by_user '/tmp/something', 'dummyuser1', 'r'}
    it { should eq  'runuser -c "test -r /tmp/something" dummyuser1' }
  end

  context 'write access' do
    subject {commands.check_access_by_user '/tmp/somethingw', 'dummyuser2', 'w'}
    it { should eq  'runuser -c "test -w /tmp/somethingw" dummyuser2' }
  end

  context 'execute access' do
    subject {commands.check_access_by_user '/tmp/somethingx', 'dummyuser3', 'x'}
    it { should eq  'runuser -c "test -x /tmp/somethingx" dummyuser3' }
  end
end
