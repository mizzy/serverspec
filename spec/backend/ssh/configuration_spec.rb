require 'spec_helper'

include SpecInfra::Helper::RedHat
include SpecInfra::Helper::Ssh

ssh = double

describe 'configurations are not set' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root'  } }
      c.ssh = ssh
    end
  end

  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'test -f /etc/passwd' }
  end
end

describe 'path is set' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root'  } }
      c.ssh = ssh
    end
  end

  let(:path) { '/sbin:/usr/sbin' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end
end

describe 'pre_command is set and user is root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root' } }
      c.ssh = ssh
    end
  end

  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'source ~/.zshrc && test -f /etc/passwd' }
  end
end

describe 'pre_command is set and user is non-root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
    end
  end

  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'sudo source ~/.zshrc && sudo test -f /etc/passwd' }
  end
end

describe 'pre_command is not set and user is non-root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
    end
  end

  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'sudo test -f /etc/passwd' }
  end
end


describe 'path pre_command and set and user is non-root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
    end
  end

  let(:path) { '/sbin:/usr/sbin' }
  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'sudo env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && sudo env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end
end

describe 'path pre_command and set and user is non-root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root' } }
      c.ssh = ssh
    end
  end

  let(:path) { '/sbin:/usr/sbin' }
  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end
end

describe 'user is non-root for check_selinux' do
  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_disabled }
    its(:command) { should eq "sudo test ! -f /etc/selinux/config || (sudo getenforce | grep -i -- disabled && sudo grep -i -- ^SELINUX=disabled$ /etc/selinux/config)" }
  end

  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_enforcing }
    its(:command) { should eq "sudo getenforce | grep -i -- enforcing && sudo grep -i -- ^SELINUX=enforcing$ /etc/selinux/config" }
  end

  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_permissive }
    its(:command) { should eq "sudo getenforce | grep -i -- permissive && sudo grep -i -- ^SELINUX=permissive$ /etc/selinux/config" }
  end
end

describe 'path is set and user is non-root for check_selinux' do
  let(:path) { "/sbin:/usr/sbin" }

  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_disabled }
    its(:command) { should eq "sudo env PATH=/sbin:/usr/sbin:$PATH test ! -f /etc/selinux/config || (sudo env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- disabled && sudo env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=disabled$ /etc/selinux/config)" }
  end

  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_enforcing }
    its(:command) { should eq "sudo env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- enforcing && sudo env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=enforcing$ /etc/selinux/config" }
  end

  context selinux do
    before :all do
      RSpec.configure do |c|
        ssh.stub(:options) { { :user => 'foo' } }
        c.ssh = ssh
      end
    end
    it { should be_permissive }
    its(:command) { should eq "sudo env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- permissive && sudo env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=permissive$ /etc/selinux/config" }
  end
end
