require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec routing table matchers of Solaris family' do
  it_behaves_like 'support routing table have_entry matcher'
end
