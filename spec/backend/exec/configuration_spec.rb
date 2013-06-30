require 'spec_helper'

require 'serverspec/helper/base'
include Serverspec::Helper::Base
include Serverspec::Helper::Exec

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
