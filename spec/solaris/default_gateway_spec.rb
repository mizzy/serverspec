require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec default gateway matchers of Solaris family' do
  it_behaves_like 'support default gateway matcher'
end
