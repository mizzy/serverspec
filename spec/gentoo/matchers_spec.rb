require 'spec_helper'

describe 'Serverspec matchers of Gentoo family', :os => :gentoo do
  it_behaves_like 'support be_enabled matcher', 'sshd'
  it_behaves_like 'support be_installed matcher', 'openssh'
  it_behaves_like 'support be_running matcher', 'sshd'
  it_behaves_like 'support be_running.under("supervisor") matcher', 'growthforecast'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'

  it_behaves_like 'support be_mounted matcher', '/'
  it_behaves_like 'support be_mounted.with matcher', '/'
  it_behaves_like 'support be_mounted.only_with matcher', '/'

  it_behaves_like 'support be_reachable matcher', '127.0.0.1'
  it_behaves_like 'support be_reachable.with matcher', '127.0.0.1'

  it_behaves_like 'support be_resolvable matcher', 'localhost'
  it_behaves_like 'support be_resolvable.by matcher', 'localhost', 'hosts'
  it_behaves_like 'support be_resolvable.by matcher', 'localhost', 'dns'
  it_behaves_like 'support be_directory matcher', '/etc/ssh'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support contain.from.to matcher', 'Gemfile', 'rspec', /^group :test do/, /^end/
  it_behaves_like 'support contain.after matcher', 'Gemfile', 'rspec', /^group :test do/
  it_behaves_like 'support contain.before matcher', 'Gemfile', 'rspec', /^end/
  it_behaves_like 'support match_md5checksum matcher', '/etc/services', '35435ea447c19f0ea5ef971837ab9ced'
  it_behaves_like 'support be_user matcher', 'root'
  it_behaves_like 'support be_group matcher', 'wheel'

  # Test for case of not registered in the service, but running as process.
  it_behaves_like 'support be_running matcher', 'udevd'

  it_behaves_like 'support be_mode matcher', '/etc/passwd', 644

  it_behaves_like 'support be_owned_by matcher', '/etc/passwd', 'root'
  it_behaves_like 'support be_grouped_into matcher', '/etc/passwd', 'root'

  it_behaves_like 'support have_cron_entry matcher', 'cron', '* * * * * /usr/bin/foo'
  it_behaves_like 'support have_cron_entry.with_user matcher', 'cron', '* * * * * /usr/bin/foo', 'root'

  it_behaves_like 'support be_linked_to matcher', '/etc/pam.d/system-auth', '/etc/pam.d/system-auth-ac'

  it_behaves_like 'support be_installed.by(gem) matcher', 'jekyll'
  it_behaves_like 'support be_installed.by(gem).with_version matcher', 'jekyll', '1.0.0'

  it_behaves_like 'support belong_to_group matcher', 'root', 'root'
  it_behaves_like 'support have_gid matcher', 'root', 0
  it_behaves_like 'support have_uid matcher', 'root', 0
  it_behaves_like 'support have_login_shell matcher', 'root', '/bin/bash'
  it_behaves_like 'support have_home_directory matcher', 'root', '/root'
  it_behaves_like 'support have_authorized_key matcher', 'root', 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local'

  it_behaves_like 'support have_iptables_rule matcher', '-P INPUT ACCEPT'
  it_behaves_like 'support have_iptables_rule.with_table.with_chain matcher', '-P INPUT ACCEPT', 'mangle', 'INPUT'

  it_behaves_like 'support be_readable matcher', '/dev'
  it_behaves_like 'support be_readable_by_owner matcher', '/dev'
  it_behaves_like 'support be_readable_by_group matcher', '/dev'
  it_behaves_like 'support be_readable_by_others matcher', '/dev'

  it_behaves_like 'support be_writable matcher', '/dev'
  it_behaves_like 'support be_writable_by_owner matcher', '/dev'
  it_behaves_like 'support be_writable_by_group matcher', '/dev'
  it_behaves_like 'support be_writable_by_others matcher', '/dev'

  it_behaves_like 'support be_executable matcher', '/dev'
  it_behaves_like 'support be_executable_by_owner matcher', '/dev'
  it_behaves_like 'support be_executable_by_group matcher', '/dev'
  it_behaves_like 'support be_executable_by_others matcher', '/dev'

  it_behaves_like 'support return_exit_status matcher', 'ls /tmp', 0

  it_behaves_like 'support return_stdout matcher', 'cat /etc/resolv.conf', 'localhost'
  it_behaves_like 'support return_stdout matcher with regexp', 'cat /etc/resolv.conf', /localhost/

  it_behaves_like 'support return_stderr matcher', 'cat /foo', 'cat: /foo: No such file or directory'
  it_behaves_like 'support return_stderr matcher with regexp', 'cat /foo', /No such file or directory/

  it_behaves_like 'support linux kernel parameter checking with integer', 'net.ipv4.tcp_syncookies', 1
  it_behaves_like 'support linux kernel parameter checking with string',  'kernel.osrelease', '2.6.32-131.0.15.el6.x86_64'
  it_behaves_like 'support linux kernel parameter checking with regexp',  'net.ipv4.tcp_wmem', /4096\t16384\t4194304/
end
