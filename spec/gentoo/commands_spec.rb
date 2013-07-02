require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec commands of Gentoo family' do
  it_behaves_like 'support command check_file', '/etc/passwd'
  it_behaves_like 'support command check_directory', '/var/log'
  it_behaves_like 'support command check_socket', '/var/run/unicorn.sock'

  it_behaves_like 'support command check_mounted', '/'

  it_behaves_like 'support command check_user', 'root'
  it_behaves_like 'support command check_user', 'wheel'

  it_behaves_like 'support command check_file_md5checksum', '/etc/passewd', '96c8c50f81a29965f7af6de371ab4250'

  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'
  it_behaves_like 'support command check_process', 'httpd'

  it_behaves_like 'support command check_file_contain', '/etc/passwd', 'root'
  it_behaves_like 'support command check_file_contain_within'

  it_behaves_like 'support command check_mode', '/etc/sudoers', 440
  it_behaves_like 'support command check_owner', '/etc/sudoers', 'root'
  it_behaves_like 'support command check_grouped', '/etc/sudoers', 'wheel'

  it_behaves_like 'support command check_link', '/etc/system-release', '/etc/redhat-release'

  it_behaves_like 'support command check_belonging_group', 'root', 'wheel'

  it_behaves_like 'support command check_uid', 'root', 0
  it_behaves_like 'support command check_gid', 'root', 0

  it_behaves_like 'support command check_login_shell', 'root', '/bin/bash'
  it_behaves_like 'support command check_home_directory', 'root', '/root'

  it_behaves_like 'support command check_authorized_key'

  it_behaves_like 'support command check_selinux'

  it_behaves_like 'support command get_mode'

  it_behaves_like 'support command check_access_by_user'

  it_behaves_like 'support command check_kernel_module_loaded', 'lp'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq "rc-update show | grep -- \\^\\\\s\\*httpd\\\\s\\*\\|\\\\s\\*\\\\\\(boot\\\\\\|default\\\\\\)" }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq '/etc/init.d/httpd status' }
end

