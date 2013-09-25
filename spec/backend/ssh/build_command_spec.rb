require 'spec_helper'

RSpec.configure do |c|
  c.os      = 'RedHat'
  c.backend = 'Ssh'
end

ssh = double

describe 'build command with sudo' do
  before :each do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
      c.sudo_path = nil
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

# Alternate path for sudo command:
sudo_path = '/usr/local/bin'

describe 'build command with sudo on alternate path' do
  before :each do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
      c.sudo_path = "#{sudo_path}"
    end
  end


  context 'command pattern 1a' do
    subject { backend.build_command('test -f /etc/passwd') }
    it { should eq "#{sudo_path}/sudo test -f /etc/passwd" }
  end

  context 'command pattern 2a' do
    subject { backend.build_command('test ! -f /etc/selinux/config || (getenforce | grep -i -- disabled && grep -i -- ^SELINUX=disabled$ /etc/selinux/config)') }
    it { should eq "#{sudo_path}/sudo test ! -f /etc/selinux/config || (#{sudo_path}/sudo getenforce | grep -i -- disabled && #{sudo_path}/sudo grep -i -- ^SELINUX=disabled$ /etc/selinux/config)" }
  end

  context 'command pattern 3a' do
    subject { backend.build_command("dpkg -s apache2 && ! dpkg -s apache2 | grep -E '^Status: .+ not-installed$'") }
    it { should eq "#{sudo_path}/sudo dpkg -s apache2 && ! #{sudo_path}/sudo dpkg -s apache2 | grep -E '^Status: .+ not-installed$'" }
  end

  after :each do
    RSpec.configure do |c|
      c.sudo_path = nil
    end
  end

end
