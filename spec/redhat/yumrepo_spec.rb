require 'spec_helper'

RSpec.configure do |c|
  c.os = 'RedHat'
end

describe 'Serverspec yumrepo matchers of Red Hat family' do
  describe 'exist' do
    describe yumrepo('epel') do
      it { should exist }
      its(:command) { should eq 'LANG=C yum repolist all -C | grep ^epel' }

    end

    describe yumrepo('invalid-repository') do
      it { should_not exist }
    end
  end

  describe 'be_enabled' do
    describe yumrepo('epel') do
      it { should be_enabled }
      its(:command) { should eq 'LANG=C yum repolist all -C | grep ^epel | grep enabled' }
    end

    describe yumrepo('invalid-repository') do
      it { should_not be_enabled }
    end
  end
end
