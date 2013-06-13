require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec file matchers of Debian family' do
  it_behaves_like 'support kernel_module be_loaded matcher', 'lp'
end
