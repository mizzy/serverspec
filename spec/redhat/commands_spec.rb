require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec commands of Red Hat' do
  it_behaves_like 'support command check_file', '/etc/passwd'
  it_behaves_like 'support command check_directory', '/var/log'

  it_behaves_like 'support command check_installed_by_gem', 'jekyll'
  it_behaves_like 'support command check_installed_by_gem with_version', 'jekyll', '1.0.2'

  it_behaves_like 'support command check_mounted', '/'

  it_behaves_like 'support command check_routing_table', '192.168.100.1/24'
  it_behaves_like 'support command check_reachable'
  it_behaves_like 'support command check_resolvable'

  it_behaves_like 'support command check_user', 'root'
  it_behaves_like 'support command check_user', 'wheel'

  it_behaves_like 'support command check_listening', 80

  it_behaves_like 'support command check_file_md5checksum', '/etc/passewd', '96c8c50f81a29965f7af6de371ab4250'

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_file_contain', '/etc/passwd', 'root'
  it_behaves_like 'support command check_file_contain_within'

  it_behaves_like 'support command check_mode', '/etc/sudoers', 440
  it_behaves_like 'support command check_owner', '/etc/sudoers', 'root'
  it_behaves_like 'support command check_grouped', '/etc/sudoers', 'wheel'

  it_behaves_like 'support command check_cron_entry'

  it_behaves_like 'support command check_link', '/etc/system-release', '/etc/redhat-release'

  it_behaves_like 'support command check_belonging_group', 'root', 'wheel'

  it_behaves_like 'support command check_uid', 'root', 0
  it_behaves_like 'support command check_gid', 'root', 0

  it_behaves_like 'support command check_login_shell', 'root', '/bin/bash'
  it_behaves_like 'support command check_home_directory', 'root', '/root'

  it_behaves_like 'support command check_authorized_key'

  it_behaves_like 'support command check_iptables'
  it_behaves_like 'support command check_selinux'

  it_behaves_like 'support command get_mode'

  it_behaves_like 'support command check_kernel_module_loaded', 'lp'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq 'chkconfig --list httpd | grep 3:on' }
end

describe 'check_installed' do
  subject { commands.check_installed('httpd') }
  it { should eq 'rpm -q httpd' }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq 'service httpd status' }
end

describe 'check_access_by_user' do
  context 'read access' do
    subject {commands.check_access_by_user '/tmp/something', 'dummyuser1', 'r'}
    it { should eq  'runuser -s sh -c "test -r /tmp/something" dummyuser1' }
  end

  context 'write access' do
    subject {commands.check_access_by_user '/tmp/somethingw', 'dummyuser2', 'w'}
    it { should eq  'runuser -s sh -c "test -w /tmp/somethingw" dummyuser2' }
  end

  context 'execute access' do
    subject {commands.check_access_by_user '/tmp/somethingx', 'dummyuser3', 'x'}
    it { should eq  'runuser -s sh -c "test -x /tmp/somethingx" dummyuser3' }
  end
end
