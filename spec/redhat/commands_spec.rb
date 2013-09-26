require 'spec_helper'

RSpec.configure do |c|
  c.os = 'RedHat'
end

describe 'check_yumrepo' do
  subject { commands.check_yumrepo('epel') }
  it { should eq 'yum repolist all -C | grep ^epel' }
end

describe 'check_yumrepo_enabled' do
  subject { commands.check_yumrepo_enabled('epel') }
  it { should eq 'yum repolist all -C | grep ^epel | grep enabled' }
end
