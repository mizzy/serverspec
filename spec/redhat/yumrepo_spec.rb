require 'spec_helper'

RSpec.configure do |c|
  c.os      = 'RedHat'
  c.backend = 'Exec'
end

describe yumrepo('epel') do
  it { should exist }
  its(:command) { should eq 'yum repolist all -C | grep ^epel' }
end

describe yumrepo('invalid-repository') do
  it { should_not exist }
end

describe yumrepo('epel') do
  it { should be_enabled }
  its(:command) { should eq 'yum repolist all -C | grep ^epel | grep enabled' }
end

describe yumrepo('invalid-repository') do
  it { should_not be_enabled }
end
