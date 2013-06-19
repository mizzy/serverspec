require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec file matchers of Gentoo family' do
  it_behaves_like 'support file be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support file be_directory matcher', '/etc/ssh'
  it_behaves_like 'support file be_socket matcher', '/var/run/unicorn.sock'
  it_behaves_like 'support file contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support file contain from to matcher', 'Gemfile', 'rspec', /^group :test do/, /^end/
  it_behaves_like 'support file contain after matcher', 'Gemfile', 'rspec', /^group :test do/
  it_behaves_like 'support file contain before matcher', 'Gemfile', 'rspec', /^end/
  it_behaves_like 'support file be_mode matcher', '/etc/passwd', 644
  it_behaves_like 'support file be_owned_by matcher', '/etc/passwd', 'root'
  it_behaves_like 'support file be_grouped_into matcher', '/etc/passwd', 'root'
  it_behaves_like 'support file be_linked_to matcher', '/etc/pam.d/system-auth', '/etc/pam.d/system-auth-ac'

  it_behaves_like 'support file be_readable matcher', '/dev'
  it_behaves_like 'support file be_readable by owner matcher', '/dev'
  it_behaves_like 'support file be_readable by group matcher', '/dev'
  it_behaves_like 'support file be_readable by others matcher', '/dev'
  it_behaves_like 'support file be_readable by specific user matcher', '/tmp', 'mail'

  it_behaves_like 'support file be_writable matcher', '/dev'
  it_behaves_like 'support file be_writable by owner matcher', '/dev'
  it_behaves_like 'support file be_writable by group matcher', '/dev'
  it_behaves_like 'support file be_writable by others matcher', '/dev'
  it_behaves_like 'support file be_writable by specific user matcher', '/tmp',  'mail'

  it_behaves_like 'support file be_executable matcher', '/dev'
  it_behaves_like 'support file be_executable by owner matcher', '/dev'
  it_behaves_like 'support file be_executable by group matcher', '/dev'
  it_behaves_like 'support file be_executable by others matcher', '/dev'
  it_behaves_like 'support file be_executable by specific user matcher', '/tmp', 'mail'

  it_behaves_like 'support file be_mounted matcher', '/'
  it_behaves_like 'support file be_mounted with matcher', '/'
  it_behaves_like 'support file be_mounted only with matcher', '/'

  it_behaves_like 'support file match_md5checksum matcher', '/etc/services', '35435ea447c19f0ea5ef971837ab9ced'
end
