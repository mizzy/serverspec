require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec interface matchers of Debian family' do
  it_behaves_like 'support interface matcher', 'eth0'
end
