require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec selinux matchers of Gentoo family' do
  it_behaves_like 'support selinux be_enforcing matcher'
  it_behaves_like 'support selinux be_permissive matcher'
  it_behaves_like 'support selinux be_disabled matcher'
end
