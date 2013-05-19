require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec default gateway matchers of Darwin family' do
  it_behaves_like 'support default gateway matcher'
end
