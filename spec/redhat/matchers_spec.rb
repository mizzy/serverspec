require 'spec_helper'

describe 'Serverspec matchers of Red Hat family', :serverspec => :redhat do
  let(:test_server_host) { 'serverspec-redhat-host' }

  it_behaves_like 'support be_enabled matcher', 'sshd'
  it_behaves_like 'support be_installed matcher', 'openssh'
  it_behaves_like 'support be_running matcher', 'sshd'
  it_behaves_like 'support be_listening matcher', 22
  it_behaves_like 'support be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
end
