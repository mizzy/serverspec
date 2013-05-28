require 'spec_helper'

require 'serverspec/helper/exec'
require 'serverspec/helper/base'
include Serverspec::Helper::Exec
include Serverspec::Helper::Base

describe 'Default path setting' do
  subject { backend.build_command('ls') }
  it { should eq 'PATH=/sbin:/usr/sbin:$PATH ls' }
end

describe 'Custom path setting' do
  before :all do
    RSpec.configure do |c|
      c.path = '/usr/local/rbenv/shims'
    end
  end
  subject { backend.build_command('gem') }
  it { should eq 'PATH=/usr/local/rbenv/shims:/sbin:/usr/sbin:$PATH gem' }
end
