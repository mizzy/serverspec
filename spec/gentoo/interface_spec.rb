require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec interface matchers of Gentoo family' do
  it_behaves_like 'support interface matcher', 'eth0'
end
