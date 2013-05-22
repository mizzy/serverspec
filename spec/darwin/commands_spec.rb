require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec commands of Darwin family' do
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

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_file_contain', '/etc/passwd', 'root'
  it_behaves_like 'support command check_file_contain_within'
end

describe 'check_mode' do
  subject { commands.check_mode('/etc/sudoers', 440) }
  it { should eq 'stat -f %A /etc/sudoers | grep -- \\^440\\$' }
end

describe 'check_owner' do
  subject { commands.check_owner('/etc/passwd', 'root') }
  it { should eq 'stat -f %Su /etc/passwd | grep -- \\^root\\$' }
end

describe 'check_grouped' do
  subject { commands.check_grouped('/etc/passwd', 'wheel') }
  it { should eq 'stat -f %Sg /etc/passwd | grep -- \\^wheel\\$' }
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
  subject { commands.check_link('/etc/system-release', '/etc/darwin-release') }
  it { should eq 'stat -c %N /etc/system-release | grep -- /etc/darwin-release' }
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

describe 'get_mode' do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -f %A /dev' }
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
