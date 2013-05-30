require 'spec_helper'

require 'serverspec/helper/exec'
require 'serverspec/helper/base'
include Serverspec::Helper::Exec
include Serverspec::Helper::RedHat

describe package('httpd') do
  let(:path) { '/sbin:/usr/sbin' }
  it { should be_enabled }
end
