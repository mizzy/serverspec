require 'spec_helper'

describe 'Serverspec matchers of Red Hat family', :serverspec => :redhat do
  let(:test_server_host) { 'serverspec-redhat-host' }

  describe 'be_enabled' do
    describe 'sshd' do
      it { should be_enabled }
    end

    describe 'this-is-dummy-service' do
      it { should_not be_enabled }
    end
  end

  describe 'be_installed' do
    describe 'openssh' do
      it { should be_installed }
    end

    describe 'this-is-dummy-package' do
      it { should_not be_installed }
    end
  end

  describe 'be_running' do
    describe 'sshd' do
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
      it { should contain 'This is the sshd server system-wide configuration file' }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain 'This is duymmy text!!' }
    end
  end
end
