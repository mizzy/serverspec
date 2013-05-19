require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec routing table matchers of Red Hat family' do
  it_behaves_like 'support routing table have_entry matcher'
end
