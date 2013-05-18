require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec port matchers of Gentoo family' do
  it_behaves_like 'support port listening matcher', 80
end
