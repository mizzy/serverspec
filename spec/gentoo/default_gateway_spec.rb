require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec default gateway matchers of Gentoo family' do
  it_behaves_like 'support default gateway matcher'
end
