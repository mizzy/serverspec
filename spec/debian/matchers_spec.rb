require 'spec_helper'

describe 'Serverspec matchers of Debian family', :serverspec => :debian do
  let(:test_server_host) { 'serverspec-debian-host' }

  it_behaves_like 'support be_enabled matcher', 'rc.local'
  it_behaves_like 'support be_installed matcher', 'openssh-server'
  it_behaves_like 'support be_running matcher', 'ssh'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'See the sshd_config(5) manpage'
end
