require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec user matchers of Debian family' do
  it_behaves_like 'support group exist matcher', 'root'
  it_behaves_like 'support group have_gid matcher', 'root', 0
end
