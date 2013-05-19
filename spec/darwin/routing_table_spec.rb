require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec routing table matchers of Darwin family' do
  it_behaves_like 'support routing table have_entry matcher'
end
