require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec yumrepo matchers of Red Hat family' do
  describe 'exist' do
    describe yumrepo('epel') do
      it { should exist }
    end

    describe yumrepo('invalid-repository') do
      it { should_not exist }
    end
  end

  describe 'be_enabled' do
    describe yumrepo('epel') do
      it { should be_enabled }
    end

    describe yumrepo('invalid-repository') do
      it { should_not be_enabled }
    end
  end
end
