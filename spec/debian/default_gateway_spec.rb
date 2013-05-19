require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec default gateway matchers of Debian family' do
  it_behaves_like 'support default gateway matcher'
end
