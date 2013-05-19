require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec selinux matchers of Debian family' do
  it_behaves_like 'support selinux be_enforcing matcher'
  it_behaves_like 'support selinux be_permissive matcher'
  it_behaves_like 'support selinux be_disabled matcher'
end
