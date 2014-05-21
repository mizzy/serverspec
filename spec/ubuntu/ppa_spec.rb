require 'spec_helper'

include SpecInfra::Helper::Ubuntu

describe 'Serverspec Personal Package Archives(PPA) machers of Ubuntu' do
  describe 'exist' do
    describe ppa('username/ppa-name') do
      it { should exist }
    end

    describe ppa('invalid-ppa') do
      it { should_not exist }
    end
  end

  describe 'be_enabled' do
    describe ppa('username/ppa-name') do
      it { should be_enabled }
    end

    describe ppa('invalid-ppa') do
      it { should_not be_enabled }
    end
  end
end
