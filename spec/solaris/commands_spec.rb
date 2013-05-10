require 'spec_helper'

describe 'check_enabled', :os => :solaris do
  subject { commands.check_enabled('httpd') }
  it { should eq "svcs -l httpd 2> /dev/null | grep 'enabled      true'" }
end

describe 'check_file', :os => :solaris do
  subject { commands.check_file('/etc/passwd') }
  it { should eq 'test -f /etc/passwd' }
end

describe 'check_mounted', :os => :solaris  do
  subject { commands.check_mounted('/') }
  it { should eq "mount | grep -w -- on\\ /" }
end

describe 'check_reachable', :os => :solaris  do
  context "connect with name from /etc/services to localhost" do
    subject { commands.check_reachable('localhost', 'ssh', 'tcp', 1) }
    it { should eq "nc -vvvvzt localhost ssh -w 1" }
  end
  context "connect with ip and port 11111 and timeout of 5" do
    subject { commands.check_reachable('127.0.0.1', '11111', 'udp', 5) }
    it { should eq "nc -vvvvzu 127.0.0.1 11111 -w 5" }
  end
  context "do a ping" do
    subject { commands.check_reachable('127.0.0.1', nil, 'icmp', 1) }
    it { should eq "ping -n 127.0.0.1 -w 1 -c 2" }
  end
end

describe 'check_resolvable', :os => :solaris  do
  context "resolve localhost by hosts" do
    subject { commands.check_resolvable('localhost', 'hosts') }
    it { should eq "grep -w -- localhost /etc/hosts" }
  end
  context "resolve localhost by dns" do
    subject { commands.check_resolvable('localhost', 'dns') }
    it { should eq "nslookup -timeout=1 localhost" }
  end
  context "resolve localhost with default settings" do
    subject { commands.check_resolvable('localhost',nil) }
    it { should eq 'getent hosts localhost' }
  end
end

describe 'check_directory', :os => :solaris do
  subject { commands.check_directory('/var/log') }
  it { should eq 'test -d /var/log' }
end

describe 'check_user', :os => :solaris do
  subject { commands.check_user('root') }
  it { should eq 'id root' }
end

describe 'check_group', :os => :solaris do
  subject { commands.check_group('wheel') }
  it { should eq 'getent group | grep -wq -- wheel' }
end

describe 'check_installed', :os => :solaris do
  subject { commands.check_installed('httpd') }
  it { should eq 'pkg list -H httpd 2> /dev/null' }
end

describe 'check_listening', :os => :solaris do
  subject { commands.check_listening(80) }
  it { should eq "netstat -an 2> /dev/null | egrep 'LISTEN|Idle' | grep -- .80\\ " }
end

describe 'check_running', :os => :solaris do
  subject { commands.check_running('httpd') }
  it { should eq "svcs -l httpd status 2> /dev/null |grep 'state        online'" }
end

describe 'check_running_under_supervisor', :os => :solaris do
  subject { commands.check_running_under_supervisor('httpd') }
  it { should eq 'supervisorctl status httpd' }
end

describe 'check_process', :os => :solaris do
  subject { commands.check_process('httpd') }
  it { should eq 'ps aux | grep -w -- httpd | grep -qv grep' }
end

describe 'check_file_contain', :os => :solaris do
  subject { commands.check_file_contain('/etc/passwd', 'root') }
  it { should eq "grep -q -- root /etc/passwd" }
end

describe 'check_file_contain_within', :os => :solaris do
  context 'contain a pattern in the file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec') }
    it { should eq "sed -n 1,\\$p Gemfile | grep -q -- rspec /dev/stdin" }
  end

  context 'contain a pattern after a line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/') }
    it { should eq "sed -n /\\^group\\ :test\\ do/,\\$p Gemfile | grep -q -- rspec /dev/stdin" }
  end

  context 'contain a pattern before a line in a file' do
    subject {commands.check_file_contain_within('Gemfile', 'rspec', nil, '/^end/') }
    it { should eq "sed -n 1,/\\^end/p Gemfile | grep -q -- rspec /dev/stdin" }
  end

  context 'contain a pattern from within a line and another line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/', '/^end/') }
    it { should eq "sed -n /\\^group\\ :test\\ do/,/\\^end/p Gemfile | grep -q -- rspec /dev/stdin" }
  end
end

describe 'check_file_md5checksum', :os => :solaris do
  subject { commands.check_file_md5checksum('/etc/passwd', '96c8c50f81a29965f7af6de371ab4250') }
  it { should eq "md5sum /etc/passwd | grep -iw -- ^96c8c50f81a29965f7af6de371ab4250" }
end

describe 'check_mode', :os => :solaris do
  subject { commands.check_mode('/etc/sudoers', 440) }
  it { should eq 'stat -c %a /etc/sudoers | grep -- \\^440\\$' }
end

describe 'check_owner', :os => :solaris do
  subject { commands.check_owner('/etc/passwd', 'root') }
  it { should eq 'stat -c %U /etc/passwd | grep -- \\^root\\$' }
end

describe 'check_grouped', :os => :solaris do
  subject { commands.check_grouped('/etc/passwd', 'wheel') }
  it { should eq 'stat -c %G /etc/passwd | grep -- \\^wheel\\$' }
end

describe 'check_cron_entry', :os => :solaris do
  subject { commands.check_cron_entry('root', '* * * * * /usr/local/bin/batch.sh') }
  it { should eq 'crontab -l root | grep -- \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ /usr/local/bin/batch.sh' }
end

describe 'check_link', :os => :solaris do
  subject { commands.check_link('/etc/system-release', '/etc/redhat-release') }
  it { should eq 'stat -c %N /etc/system-release | grep -- /etc/redhat-release' }
end

describe 'check_installed_by_gem', :os => :solaris do
  subject { commands.check_installed_by_gem('jekyll') }
  it { should eq 'gem list --local | grep -- \\^jekyll\\ ' }
end

describe 'check_belonging_group', :os => :solaris do
  subject { commands.check_belonging_group('root', 'wheel') }
  it { should eq "id -Gn root | grep -- wheel" }
end

describe 'have_gid', :os => :solaris do
  subject { commands.check_gid('root', 0) }
  it { should eq "getent group | grep -- \\^root: | cut -f 3 -d ':' | grep -w -- 0" }
end

describe 'have_uid', :os => :solaris do
  subject { commands.check_uid('root', 0) }
  it { should eq "id root | grep -- \\^uid\\=0\\(" }
end

describe 'have_login_shell', :os => :solaris do
  subject { commands.check_login_shell('root', '/bin/bash') }
  it { should eq "getent passwd root | cut -f 7 -d ':' | grep -w -- /bin/bash" }
end

describe 'have_home_directory', :os => :solaris do
  subject { commands.check_home_directory('root', '/root') }
  it { should eq "getent passwd root | cut -f 6 -d ':' | grep -w -- /root" }
end

describe 'have_authorized_key', :os => :solaris do
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

describe 'check_zfs', :os => :solaris do
  context 'check without properties' do
    subject { commands.check_zfs('rpool') }
    it { should eq "/sbin/zfs list -H rpool" }
  end

  context 'check with a property' do
    subject { commands.check_zfs('rpool', { 'mountpoint' => '/rpool' }) }
    it { should eq "/sbin/zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
  end

  context 'check with multiple properties' do
    subject { commands.check_zfs('rpool', { 'mountpoint'  => '/rpool', 'compression' => 'off' }) }
    it { should eq "/sbin/zfs list -H -o compression rpool | grep -- \\^off\\$ && /sbin/zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
  end
end

describe 'get_mode', :os => :solaris do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -c %a /dev' }
end

describe 'check_ip_filter_rule', :os => :solaris do
  subject { commands.check_ipfilter_rule('pass in quick on lo0 all') }
  it { should eq "/sbin/ipfstat -io 2> /dev/null | grep -- pass\\ in\\ quick\\ on\\ lo0\\ all" }
end

describe 'check_ipnat_rule', :os => :solaris do
  subject { commands.check_ipnat_rule('map net1 192.168.0.0/24 -> 0.0.0.0/32') }
  it { should eq "/sbin/ipnat -l 2> /dev/null | grep -- \\^map\\ net1\\ 192.168.0.0/24\\ -\\>\\ 0.0.0.0/32\\$" }
end

describe 'check_svcprop', :os => :solaris do
  subject { commands.check_svcprop('svc:/network/http:apache22', 'httpd/enable_64bit','false') }
  it { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$" }
end

describe 'check_svcprops', :os => :solaris do
  subject {
    commands.check_svcprops('svc:/network/http:apache22', {
      'httpd/enable_64bit' => 'false',
      'httpd/server_type'  => 'worker',
    })
  }
  it { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$ && svcprop -p httpd/server_type svc:/network/http:apache22 | grep -- \\^worker\\$" }
end

