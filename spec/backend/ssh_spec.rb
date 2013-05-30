require 'spec_helper'

require 'serverspec/helper/base'
include Serverspec::Helper::Base

ssh = double

describe 'root user', :backend => :ssh do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'root'  } }
      c.ssh = ssh
    end
  end
  subject { backend.build_command('service httpd status') }
  it { should eq 'service httpd status' }
end

describe 'non-root user', :backend => :ssh do
  before :all do
    RSpec.configure do |c|
      ssh.stub(:options) { { :user => 'foo'  } }
      c.ssh = ssh
    end
  end
  subject { backend.build_command('service httpd status') }
  it { should eq 'sudo service httpd status' }
end
