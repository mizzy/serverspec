require 'spec_helper'

describe 'Serverspec matchers of Solaris family', :os => :solaris do
  let(:test_server_host) { 'serverspec-solaris-host' }

  it_behaves_like 'support be_enabled matcher', 'svc:/network/ssh:default'
  it_behaves_like 'support be_installed matcher', 'service/network/ssh'
  it_behaves_like 'support be_running matcher', 'svc:/network/ssh:default'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support be_directory matcher', '/etc/ssh'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'Configuration file for sshd(1m) (see also sshd_config(4))'
  it_behaves_like 'support be_user matcher', 'root'
  it_behaves_like 'support be_group matcher', 'root'
end
