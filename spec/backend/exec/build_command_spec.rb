require 'spec_helper'

include SpecInfra::Helper::Exec

describe 'build command with path' do
  before :each do
    RSpec.configure do |c|
      c.path = '/sbin:/usr/sbin'
    end
  end

  context 'command pattern 1' do
    subject { backend.build_command('test -f /etc/passwd') }
    it { should eq 'env PATH=/sbin:/usr/sbin:$PATH test -f /etc/passwd' }
  end

  context 'command pattern 2' do
    subject { backend.build_command('test ! -f /etc/selinux/config || (getenforce | grep -i -- disabled && grep -i -- ^SELINUX=disabled$ /etc/selinux/config)') }
      it { should eq 'env PATH=/sbin:/usr/sbin:$PATH test ! -f /etc/selinux/config || (env PATH=/sbin:/usr/sbin:$PATH getenforce | grep -i -- disabled && env PATH=/sbin:/usr/sbin:$PATH grep -i -- ^SELINUX=disabled$ /etc/selinux/config)' }
  end

  context 'command pattern 3' do
    subject { backend.build_command("dpkg -s apache2 && ! dpkg -s apache2 | grep -E '^Status: .+ not-installed$'") }
    it { should eq "env PATH=/sbin:/usr/sbin:$PATH dpkg -s apache2 && ! env PATH=/sbin:/usr/sbin:$PATH dpkg -s apache2 | grep -E '^Status: .+ not-installed$'" }
  end

  after :each do
    RSpec.configure do |c|
      c.path = nil
    end
  end
end
