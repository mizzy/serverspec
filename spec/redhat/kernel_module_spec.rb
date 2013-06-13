require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec file matchers of Red Hat family' do
  it_behaves_like 'support kernel_module be_loaded matcher', 'lp'
end
