require 'spec_helper'

include SpecInfra::Helper::RedHat
include SpecInfra::Helper::Exec

describe 'configurations are not set' do
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'test -f /etc/passwd' }
  end
end

describe 'path is set' do
  let(:path) { '/sbin:/usr/sbin' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end
end

describe 'path is reset to nil' do
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'test -f /etc/passwd' }
  end
end

describe 'pre_command is set' do
  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'source ~/.zshrc && test -f /etc/passwd' }
  end
end

describe 'path and pre_command are set' do
  let(:path) { '/sbin:/usr/sbin' }
  let(:pre_command) { 'source ~/.zshrc' }
  context file('/etc/passwd') do
    it { should be_file }
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end
end

describe 'path is set for check_selinux' do
  let(:path) { '/sbin:/usr/sbin' }
  context selinux do
    it { should be_disabled }
    its(:command) { should eq "env PATH=/sbin:/usr/sbin:$PATH test ! -f /etc/selinux/config || (env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- disabled && env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=disabled$ /etc/selinux/config)" }
  end

  context selinux do
    it { should be_enforcing }
    its(:command) { should eq "env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- enforcing && env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=enforcing$ /etc/selinux/config" }
  end

  context selinux do
    it { should be_permissive }
    its(:command) { should eq "env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- permissive && env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=permissive$ /etc/selinux/config" }
  end
end
