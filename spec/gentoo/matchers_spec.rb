require 'spec_helper'

describe 'Serverspec matchers of Gentoo family', :os => :gentoo do
  it_behaves_like 'support be_enabled matcher', 'sshd'
  it_behaves_like 'support be_installed matcher', 'openssh'
  it_behaves_like 'support be_running matcher', 'sshd'
  it_behaves_like 'support be_running.under("supervisor") matcher', 'growthforecast'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support be_directory matcher', '/etc/ssh'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support contain.from.to matcher', 'Gemfile', 'rspec', /^group :test do/, /^end/
  it_behaves_like 'support contain.after matcher', 'Gemfile', 'rspec', /^group :test do/
  it_behaves_like 'support contain.before matcher', 'Gemfile', 'rspec', /^end/
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

  it_behaves_like 'support have_iptables_rule matcher', '-P INPUT ACCEPT'
  it_behaves_like 'support have_iptables_rule.with_table.with_chain matcher', '-P INPUT ACCEPT', 'mangle', 'INPUT'

  it_behaves_like 'support get_stdout matcher', 'whoami', 'root'

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
end
