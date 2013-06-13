require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec file matchers of Gentoo family' do
  it_behaves_like 'support kernel_module be_loaded matcher', 'lp'
end
