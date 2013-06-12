require 'spec_helper'

require 'serverspec/helper/base'
include Serverspec::Helper::Base
include Serverspec::Helper::Ssh

ssh = double

describe 'configurations are not set' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root'  } }
      c.ssh = ssh
    end
  end

  context package('httpd') do
    its(:command) { should eq 'command' }
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
  context package('httpd') do
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH command' }
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
  context package('httpd') do
    its(:command) { should eq 'source ~/.zshrc && command' }
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
  context package('httpd') do
    its(:command) { should eq 'sudo source ~/.zshrc && sudo command' }
  end
end

describe 'pre_command is not set and user is non-root' do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo' } }
      c.ssh = ssh
    end
  end

  context package('httpd') do
    its(:command) { should eq 'sudo command' }
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
  context package('httpd') do
    its(:command) { should eq 'sudo env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && sudo env PATH=/sbin:/usr/sbin:$PATH command' }
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
  context package('httpd') do
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && env PATH=/sbin:/usr/sbin:$PATH command' }
  end
end
