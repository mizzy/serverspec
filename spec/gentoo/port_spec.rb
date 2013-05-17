require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec package matchers of Gentoo family' do
  it_behaves_like 'support port listening matcher', 80
end
