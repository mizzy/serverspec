require 'spec_helper'

include Serverspec::Helper::Ssh

ssh = double


describe 'build command with sudo' do
  before :each do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo'  } }
      c.ssh = ssh
    end
  end

  context 'command pattern 1' do
    subject { backend.build_command('test -f /etc/passwd') }
    it { should eq 'sudo test -f /etc/passwd' }
  end

  context 'command pattern 2' do
    subject { backend.build_command('test ! -f /etc/selinux/config || (getenforce | grep -i -- disabled && grep -i -- ^SELINUX=disabled$ /etc/selinux/config)') }
      it { should eq 'sudo test ! -f /etc/selinux/config || (sudo getenforce | grep -i -- disabled && sudo grep -i -- ^SELINUX=disabled$ /etc/selinux/config)' }
  end

  context 'command pattern 3' do
    subject { backend.build_command("dpkg -s apache2 && ! dpkg -s apache2 | grep -E '^Status: .+ not-installed$'") }
    it { should eq "sudo dpkg -s apache2 && ! sudo dpkg -s apache2 | grep -E '^Status: .+ not-installed$'" }
  end
end
