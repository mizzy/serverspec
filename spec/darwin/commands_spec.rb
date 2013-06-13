require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec commands of Darwin family' do
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

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_file_contain', '/etc/passwd', 'root'
  it_behaves_like 'support command check_file_contain_within'

  it_behaves_like 'support command check_cron_entry'

  it_behaves_like 'support command check_link', '/etc/system-release', '/etc/darwin-release'

  it_behaves_like 'support command check_belonging_group', 'root', 'wheel'

  it_behaves_like 'support command check_uid', 'root', 0
  it_behaves_like 'support command check_gid', 'root', 0

  it_behaves_like 'support command check_login_shell', 'root', '/bin/bash'
  it_behaves_like 'support command check_home_directory', 'root', '/root'

  it_behaves_like 'support command check_authorized_key'
end

describe 'check_mode' do
  subject { commands.check_mode('/etc/sudoers', 440) }
  it { should eq 'stat -f%Lp /etc/sudoers | grep -- \\^440\\$' }
end

describe 'check_owner' do
  subject { commands.check_owner('/etc/passwd', 'root') }
  it { should eq 'stat -f %Su /etc/passwd | grep -- \\^root\\$' }
end

describe 'check_grouped' do
  subject { commands.check_grouped('/etc/passwd', 'wheel') }
  it { should eq 'stat -f %Sg /etc/passwd | grep -- \\^wheel\\$' }
end

describe 'get_mode' do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -f%Lp /dev' }
end

describe 'check_access_by_user' do
  context 'read access' do
    subject {commands.check_access_by_user '/tmp/something', 'dummyuser1', 'r'}
    it { should eq 'sudo -u dummyuser1 -s /bin/test -r /tmp/something' }
  end

  context 'write access' do
    subject {commands.check_access_by_user '/tmp/somethingw', 'dummyuser2', 'w'}
    it { should eq 'sudo -u dummyuser2 -s /bin/test -w /tmp/somethingw' }
  end

  context 'execute access' do
    subject {commands.check_access_by_user '/tmp/somethingx', 'dummyuser3', 'x'}
    it { should eq 'sudo -u dummyuser3 -s /bin/test -x /tmp/somethingx' }
  end
end

describe 'check_file_md5checksum' do
  subject { commands.check_file_md5checksum('/usr/bin/rsync', '03ba2dcdd50ec3a7a45d3900902a83ce') }
  it { should eq "openssl md5 /usr/bin/rsync | cut -d'=' -f2 | cut -c 2- | grep -E ^03ba2dcdd50ec3a7a45d3900902a83ce$" }
end
