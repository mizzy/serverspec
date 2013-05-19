require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec user matchers of Solaris family' do
  it_behaves_like 'support group exist matcher', 'root'
  it_behaves_like 'support group have_gid matcher', 'root', 0
end
