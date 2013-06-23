require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec repository matchers of Red Hat family' do
  it_behaves_like 'support repository exist matcher', 'epel'
  it_behaves_like 'support repository be_enabled matcher', 'epel'
end
