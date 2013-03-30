require 'spec_helper'

describe 'Serverspec matchers of Debian family', :os => :debian do
  it_behaves_like 'support be_enabled matcher', 'rc.local'
  it_behaves_like 'support be_installed matcher', 'openssh-server'
  it_behaves_like 'support be_running matcher', 'ssh'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'See the sshd_config(5) manpage'
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

  it_behaves_like 'support be_installed_by_gem matcher', 'jekyll'
  it_behaves_like 'support be_installed_by_gem.with_version matcher', 'jekyll', '1.0.0'

  it_behaves_like 'support belong_to_group matcher', 'root', 'root'

  it_behaves_like 'support have_iptables_rule matcher', '-P INPUT ACCEPT'
  it_behaves_like 'support have_iptables_rule.with_table.with_chain matcher', '-P INPUT ACCEPT', 'mangle', 'INPUT'

end
