require 'spec_helper'

require 'serverspec/helper/exec'
require 'serverspec/helper/base'
include Serverspec::Helper::Exec
include Serverspec::Helper::Base

describe 'path is not set' do
  context package('httpd') do
    its(:command) { should eq 'command' }
  end
end

describe 'path is set' do
  let(:path) { '/sbin:/usr/sbin' }
  context package('httpd') do
    its(:command) { should eq 'PATH=/sbin:/usr/sbin:$PATH command' }
  end
end
