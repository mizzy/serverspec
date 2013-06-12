require 'spec_helper'

require 'serverspec/helper/base'
include Serverspec::Helper::Base
include Serverspec::Helper::Exec

describe 'configurations are not set' do
  context package('httpd') do
    its(:command) { should eq 'command' }
  end
end

describe 'path is set' do
  let(:path) { '/sbin:/usr/sbin' }
  context package('httpd') do
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH command' }
  end
end

describe 'pre_command is set' do
  let(:pre_command) { 'source ~/.zshrc' }
  context package('httpd') do
    its(:command) { should eq 'source ~/.zshrc && command' }
  end
end

describe 'path and pre_command are set' do
  let(:path) { '/sbin:/usr/sbin' }
  let(:pre_command) { 'source ~/.zshrc' }
  context package('httpd') do
    its(:command) { should eq 'env PATH=/sbin:/usr/sbin:$PATH source ~/.zshrc && env PATH=/sbin:/usr/sbin:$PATH command' }
  end
end
