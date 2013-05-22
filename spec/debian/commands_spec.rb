require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec commands of Debian family' do
  it_behaves_like 'support command check_file', '/etc/passwd'
  it_behaves_like 'support command check_directory', '/var/log'

  it_behaves_like 'support command check_installed_by_gem', 'jekyll'
  it_behaves_like 'support command check_installed_by_gem', 'jekyll', '1.0.2'

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
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq 'ls /etc/rc3.d/ | grep -- httpd' }
end

describe 'check_installed'  do
  subject { commands.check_installed('httpd') }
  it { should eq 'dpkg -s httpd' }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq '/sbin/service httpd status' }
end

describe 'check_grouped' do
  subject { commands.check_grouped('/etc/passwd', 'wheel') }
  it { should eq 'stat -c %G /etc/passwd | grep -- \\^wheel\\$' }
end

describe 'check_cron_entry' do
  context 'specify root user' do
    subject { commands.check_cron_entry('root', '* * * * * /usr/local/bin/batch.sh') }
    it { should eq 'crontab -u root -l | grep -- \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ /usr/local/bin/batch.sh' }
  end

  context 'no specified user' do
    subject { commands.check_cron_entry(nil, '* * * * * /usr/local/bin/batch.sh') }
    it { should eq 'crontab -l | grep -- \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ /usr/local/bin/batch.sh' }
  end
end

describe 'check_link' do
  subject { commands.check_link('/etc/system-release', '/etc/redhat-release') }
  it { should eq 'stat -c %N /etc/system-release | grep -- /etc/redhat-release' }
end

describe 'check_belonging_group' do
  subject { commands.check_belonging_group('root', 'wheel') }
  it { should eq "id root | awk '{print $3}' | grep -- wheel" }
end

describe 'have_gid' do
  subject { commands.check_gid('root', 0) }
  it { should eq "getent group | grep -w -- \\^root | cut -f 3 -d ':' | grep -w -- 0" }
end

describe 'have_uid' do
  subject { commands.check_uid('root', 0) }
  it { should eq "id root | grep -- \\^uid\\=0\\(" }
end

describe 'have_login_shell' do
  subject { commands.check_login_shell('root', '/bin/bash') }
  it { should eq "getent passwd root | cut -f 7 -d ':' | grep -w -- /bin/bash" }
end

describe 'have_home_directory' do
  subject { commands.check_home_directory('root', '/root') }
  it { should eq "getent passwd root | cut -f 6 -d ':' | grep -w -- /root" }
end

describe 'have_authorized_key' do
  key = "ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH"
  escaped_key = key.gsub(/ /, '\ ')

  context 'with commented publickey' do
    commented_key = key + " foo@bar.local"
    subject { commands.check_authorized_key('root', commented_key) }
    describe 'when command insert publickey is removed comment' do
      it { should eq "grep -w -- #{escaped_key} ~root/.ssh/authorized_keys" }
    end
  end

  context 'with uncomented publickey' do
    subject { commands.check_authorized_key('root', key) }
    it { should eq "grep -w -- #{escaped_key} ~root/.ssh/authorized_keys" }
  end
end

describe 'check_ipatbles' do
  context 'check a rule without a table and a chain' do
    subject { commands.check_iptables_rule('-P INPUT ACCEPT') }
    it { should eq "/sbin/iptables -S | grep -- -P\\ INPUT\\ ACCEPT" }
  end

  context 'chack a rule with a table and a chain' do
    subject { commands.check_iptables_rule('-P INPUT ACCEPT', 'mangle', 'INPUT') }
    it { should eq "/sbin/iptables -t mangle -S INPUT | grep -- -P\\ INPUT\\ ACCEPT" }
  end
end

describe 'check_selinux' do
  context 'enforcing' do
    subject { commands.check_selinux('enforcing') }
    it { should eq "/usr/sbin/getenforce | grep -i -- enforcing" }
  end

  context 'permissive' do
    subject { commands.check_selinux('permissive') }
    it { should eq "/usr/sbin/getenforce | grep -i -- permissive" }
  end

  context 'disabled' do
    subject { commands.check_selinux('disabled') }
    it { should eq "/usr/sbin/getenforce | grep -i -- disabled" }
  end
end

describe 'get_mode' do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -c %a /dev' }
end

describe 'check_access_by_user' do
  context 'read access' do
    subject {commands.check_access_by_user '/tmp/something', 'dummyuser1', 'r'}
    it { should eq  'su -s /bin/sh -c "/usr/bin/test -r /tmp/something" dummyuser1' }
  end

  context 'write access' do
    subject {commands.check_access_by_user '/tmp/somethingw', 'dummyuser2', 'w'}
    it { should eq  'su -s /bin/sh -c "/usr/bin/test -w /tmp/somethingw" dummyuser2' }
  end

  context 'execute access' do
    subject {commands.check_access_by_user '/tmp/somethingx', 'dummyuser3', 'x'}
    it { should eq  'su -s /bin/sh -c "/usr/bin/test -x /tmp/somethingx" dummyuser3' }
  end
end
