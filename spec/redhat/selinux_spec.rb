require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec selinux matchers of Red Hat family' do
  it_behaves_like 'support selinux be_enforcing matcher'
  it_behaves_like 'support selinux be_permissive matcher'
  it_behaves_like 'support selinux be_disabled matcher'
end
