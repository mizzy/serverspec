require 'spec_helper'

include Serverspec::Helper::Solaris

describe commands.check_enabled('httpd') do
  it { should eq "svcs -l httpd 2> /dev/null | grep 'enabled      true'" }
end

describe commands.check_file('/etc/passwd') do
  it { should eq 'test -f /etc/passwd' }
end

describe commands.check_directory('/var/log') do
  it { should eq 'test -d /var/log' }
end

describe commands.check_user('root') do
  it { should eq 'id root' }
end

describe commands.check_group('wheel') do
  it { should eq 'getent group | grep -wq wheel' }
end

describe commands.check_installed('httpd') do
  it { should eq 'pkg list -H httpd 2> /dev/null' }
end

describe commands.check_listening(80) do
  it { should eq "netstat -an 2> /dev/null | egrep 'LISTEN|Idle' | grep '.80 '" }
end

describe commands.check_running('httpd') do
  it { should eq "svcs -l httpd status 2> /dev/null |grep 'state        online'" }
end

describe commands.check_running_under_supervisor('httpd') do
  it { should eq 'supervisorctl status httpd' }
end

describe commands.check_process('httpd') do
  it { should eq 'ps aux | grep -w httpd | grep -qv grep' }
end

describe commands.check_file_contain('/etc/passwd', 'root') do
  it { should eq "grep -q 'root' /etc/passwd" }
end

describe commands.check_file_contain_within('Gemfile', 'rspec') do
  it { should eq "sed -n '1,$p' Gemfile | grep -q 'rspec' -" }
end

describe commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/') do
  it { should eq "sed -n '/^group :test do/,$p' Gemfile | grep -q 'rspec' -" }
end

describe commands.check_file_contain_within('Gemfile', 'rspec', nil, '/^end/') do
  it { should eq "sed -n '1,/^end/p' Gemfile | grep -q 'rspec' -" }
end

describe commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/', '/^end/') do
  it { should eq "sed -n '/^group :test do/,/^end/p' Gemfile | grep -q 'rspec' -" }
end

describe commands.check_mode('/etc/sudoers', 440) do
  it { should eq 'stat -c %a /etc/sudoers | grep \'^440$\'' }
end

describe commands.check_owner('/etc/passwd', 'root') do
  it { should eq 'stat -c %U /etc/passwd | grep \'^root$\'' }
end

describe commands.check_grouped('/etc/passwd', 'wheel') do
  it { should eq 'stat -c %G /etc/passwd | grep \'^wheel$\'' }
end

describe commands.check_cron_entry('root', '* * * * * /usr/local/bin/batch.sh') do
  it { should eq "crontab -l root | grep '\\* \\* \\* \\* \\* /usr/local/bin/batch.sh'" }
end

describe commands.check_link('/etc/system-release', '/etc/redhat-release') do
  it { should eq 'stat -c %N /etc/system-release | grep /etc/redhat-release' }
end

describe commands.check_installed_by_gem('jekyll') do
  it { should eq 'gem list --local | grep \'^jekyll \'' }
end

describe commands.check_belonging_group('root', 'wheel') do
  it { should eq "id root | awk '{print $2}' | grep wheel" }
end

describe commands.check_zfs('rpool') do
  it { should eq "/sbin/zfs list -H rpool" }
end

describe commands.check_zfs('rpool', { 'mountpoint' => '/rpool' }) do
  it { should eq "/sbin/zfs list -H -o mountpoint rpool | grep ^/rpool$" }
end

describe commands.check_zfs('rpool', { 'mountpoint' => '/rpool' }) do
  it { should eq "/sbin/zfs list -H -o mountpoint rpool | grep ^/rpool$" }
end

check_zfs_with_multiple_properties = commands.check_zfs('rpool', {
  'mountpoint'  => '/rpool',
  'compression' => 'off',
})

describe check_zfs_with_multiple_properties do
  it { should eq "/sbin/zfs list -H -o compression rpool | grep ^off$ && /sbin/zfs list -H -o mountpoint rpool | grep ^/rpool$" }
end

describe commands.get_mode('/dev') do
  it { should eq 'stat -c %a /dev' }
end
