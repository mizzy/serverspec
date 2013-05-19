require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec default gateway matchers of Red Hat family' do
  it_behaves_like 'support default gateway matcher'
end
