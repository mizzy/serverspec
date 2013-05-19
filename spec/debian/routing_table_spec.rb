require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec routing table matchers of Debian family' do
  it_behaves_like 'support routing table have_entry matcher'
end
