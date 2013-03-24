require 'spec_helper'

describe 'Serverspec matchers of Debian family', :serverspec => :debian do
  let(:test_server_host) { 'serverspec-debian-host' }

  describe 'be_enabled' do
    describe 'rc.local' do
      it { should be_enabled }
    end

    describe 'this-is-dummy-service' do
      it { should_not be_enabled }
    end
  end

  describe 'be_installed' do
    describe 'openssh-server' do
      it { should be_installed }
    end

    describe 'this-is-dummy-package' do
      it { should_not be_installed }
    end
  end

  describe 'be_running' do
    describe 'ssh' do
      it { should be_running }
    end

    describe 'this-is-dummy-daemon' do
      it { should_not be_running }
    end
  end

  describe 'be_listening' do
    describe 'port 22' do
      it { should be_listening }
    end

    describe 'port 9999' do
      it { should_not be_listening }
    end
  end

  describe 'be_file' do
    describe '/etc/ssh/sshd_config' do
      it { should be_file }
    end

    describe '/etc/thid_is_dummy_file' do
      it { should_not be_file }
    end
  end

  describe 'contain' do
    describe '/etc/ssh/sshd_config' do
      it { should contain 'See the sshd_config(5) manpage for details' }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain 'This is duymmy text!!' }
    end
  end
end
