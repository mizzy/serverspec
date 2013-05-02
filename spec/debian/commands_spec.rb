require 'spec_helper'

describe 'check_enabled', :os => :debian do
  subject { commands.check_enabled('httpd') }
  it { should eq 'ls /etc/rc3.d/ | grep httpd' }
end

describe 'check_file', :os => :debian  do
  subject { commands.check_file('/etc/passwd') }
  it { should eq 'test -f /etc/passwd' }
end

describe 'check_directory', :os => :debian  do
  subject { commands.check_directory('/var/log') }
  it { should eq 'test -d /var/log' }
end

describe 'check_user', :os => :debian  do
  subject { commands.check_user('root') }
  it { should eq 'id root' }
end

describe 'check_group', :os => :debian  do
  subject { commands.check_group('wheel') }
  it { should eq 'getent group | grep -wq wheel' }
end

describe 'check_installed', :os => :debian  do
  subject { commands.check_installed('httpd') }
  it { should eq 'dpkg -s httpd' }
end

describe 'check_listening', :os => :debian do
  subject { commands.check_listening(80) }
  it { should eq "netstat -tunl | grep ':80 '" }
end

describe 'check_running', :os => :debian do
  subject { commands.check_running('httpd') }
  it { should eq 'service httpd status' }
end


describe 'check_running_under_supervisor', :os => :debian do
  subject { commands.check_running_under_supervisor('httpd') }
  it { should eq 'supervisorctl status httpd' }
end

describe 'check_process', :os => :debian do
  subject { commands.check_process('httpd') }
  it { should eq 'ps aux | grep -w httpd | grep -qv grep' }
end

describe 'check_file_contain', :os => :debian do
  subject { commands.check_file_contain('/etc/passwd', 'root') }
  it { should eq "grep -q 'root' /etc/passwd" }
end

describe 'check_file_contain_within', :os => :debian do
  context 'contain a pattern in the file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec') }
    it { should eq "sed -n '1,$p' Gemfile | grep -q 'rspec' -" }
  end

  context 'contain a pattern after a line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/') }
    it { should eq "sed -n '/^group :test do/,$p' Gemfile | grep -q 'rspec' -" }
  end

  context 'contain a pattern before a line in a file' do
    subject {commands.check_file_contain_within('Gemfile', 'rspec', nil, '/^end/') }
    it { should eq "sed -n '1,/^end/p' Gemfile | grep -q 'rspec' -" }
  end

  context 'contain a pattern from within a line and another line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/', '/^end/') }
    it { should eq "sed -n '/^group :test do/,/^end/p' Gemfile | grep -q 'rspec' -" }
  end
end

describe 'check_mode', :os => :debian do
  subject { commands.check_mode('/etc/sudoers', 440) }
  it { should eq 'stat -c %a /etc/sudoers | grep \'^440$\'' }
end

describe 'check_owner', :os => :debian do
  subject { commands.check_owner('/etc/passwd', 'root') }
  it { should eq 'stat -c %U /etc/passwd | grep \'^root$\'' }
end

describe 'check_grouped', :os => :debian do
  subject { commands.check_grouped('/etc/passwd', 'wheel') }
  it { should eq 'stat -c %G /etc/passwd | grep \'^wheel$\'' }
end

describe 'check_cron_entry', :os => :debian do
  subject { commands.check_cron_entry('root', '* * * * * /usr/local/bin/batch.sh') }
  it { should eq 'crontab -u root -l | grep "\* \* \* \* \* /usr/local/bin/batch.sh"' }
end

describe 'check_link', :os => :debian do
  subject { commands.check_link('/etc/system-release', '/etc/redhat-release') }
  it { should eq 'stat -c %N /etc/system-release | grep /etc/redhat-release' }
end

describe 'check_installed_by_gem', :os => :debian do
  subject { commands.check_installed_by_gem('jekyll') }
  it { should eq 'gem list --local | grep \'^jekyll \'' }
end

describe 'check_belonging_group', :os => :debian do
  subject { commands.check_belonging_group('root', 'wheel') }
  it { should eq "id root | awk '{print $3}' | grep wheel" }
end

describe 'have_gid', :os => :debian do
  subject { commands.check_gid('root', 0) }
  it { should eq "getent group | grep -w ^root | cut -f 3 -d ':' | grep -w 0" }
end

describe 'have_uid', :os => :debian do
  subject { commands.check_uid('root', 0) }
  it { should eq "id root | grep '^uid=0('" }
end

describe 'have_login_shell', :os => :debian do
  subject { commands.check_login_shell('root', '/bin/bash') }
  it { should eq "getent passwd root | cut -f 7 -d ':' | grep -w /bin/bash" }
end

describe 'have_home_directory', :os => :debian do
  subject { commands.check_home_directory('root', '/root') }
  it { should eq "getent passwd root | cut -f 6 -d ':' | grep -w /root" }
end

describe 'have_authorized_key', :os => :debian do
  key = "ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH"

  context 'with commented publickey' do
    commented_key = key + " foo@bar.local"
    subject { commands.check_authorized_key('root', commented_key) }
    describe 'when command insert publickey is removed comment' do
      it { should eq "grep -w '#{key}' ~root/.ssh/authorized_keys" }
    end
  end

  context 'with uncomented publickey' do
    subject { commands.check_authorized_key('root', key) }
    it { should eq "grep -w '#{key}' ~root/.ssh/authorized_keys" }
  end
end

describe 'check_ipatbles', :os => :debian do
  context 'check a rule without a table and a chain' do
    subject { commands.check_iptables_rule('-P INPUT ACCEPT') }
    it { should eq "iptables -S | grep '\\-P INPUT ACCEPT'" }
  end

  context 'chack a rule with a table and a chain' do
    subject { commands.check_iptables_rule('-P INPUT ACCEPT', 'mangle', 'INPUT') }
    it { should eq "iptables -t mangle -S INPUT | grep '\\-P INPUT ACCEPT'" }
  end
end

describe 'check_selinux', :os => :debian do
  context 'enforcing' do
    subject { commands.check_selinux('enforcing') }
    it { should eq "/usr/sbin/getenforce | grep -i 'enforcing'" }
  end

  context 'permissive' do
    subject { commands.check_selinux('permissive') }
    it { should eq "/usr/sbin/getenforce | grep -i 'permissive'" }
  end

  context 'disabled' do
    subject { commands.check_selinux('disabled') }
    it { should eq "/usr/sbin/getenforce | grep -i 'disabled'" }
  end
end

describe 'get_mode', :os => :debian do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -c %a /dev' }
end
