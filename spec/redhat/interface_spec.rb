require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec interface matchers of Red Hat family' do
  it_behaves_like 'support interface matcher', 'eth0'
end
