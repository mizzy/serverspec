require 'spec_helper'

require 'serverspec/helper/base'
include Serverspec::Helper::Base

describe 'Default path setting', :backend => :exec do
  subject { backend.build_command('service httpd status') }
  it { should eq 'service httpd status' }
end

describe 'Custom path setting', :backend => :exec do
  before :all do
    RSpec.configure do |c|
      c.path = '/usr/local/rbenv/shims:/sbin:/usr/sbin'
    end
  end

  subject { backend.build_command('service httpd status') }
  it { should eq 'PATH=/usr/local/rbenv/shims:/sbin:/usr/sbin:$PATH service httpd status' }

  after :all do
    RSpec.configure do |c|
      c.path = nil
    end
  end
end
