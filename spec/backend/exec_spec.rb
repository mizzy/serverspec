require 'spec_helper'

require 'serverspec/helper/exec'
require 'serverspec/helper/base'
include Serverspec::Helper::Exec
include Serverspec::Helper::Base

describe 'Default path setting' do
  subject { backend.build_command('service httpd status') }
  it { should eq 'service httpd status' }
end

describe 'Custom path setting' do
  before :all do
    RSpec.configure do |c|
      c.path = '/usr/local/rbenv/shims:/sbin:/usr/sbin'
    end
  end
  subject { backend.build_command('service httpd status') }
  it { should eq 'PATH=/usr/local/rbenv/shims:/sbin:/usr/sbin:$PATH service httpd status' }
end
