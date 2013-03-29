require 'spec_helper'

describe 'Serverspec matchers of Gentoo family', :os => :gentoo do
  it_behaves_like 'support be_enabled matcher', 'sshd'
  it_behaves_like 'support be_installed matcher', 'openssh'
  it_behaves_like 'support be_running matcher', 'sshd'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support be_directory matcher', '/etc/ssh'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support be_user matcher', 'root'
  it_behaves_like 'support be_group matcher', 'wheel'
end
