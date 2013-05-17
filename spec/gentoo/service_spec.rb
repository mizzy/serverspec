require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec service matchers of Red Hat family' do
  it_behaves_like 'support service running matcher', 'sshd'
  it_behaves_like 'support service running under supervisor matcher', 'sshd'
  it_behaves_like 'support service running under unimplemented matcher', 'sshd'
  it_behaves_like 'support service enabled matcher', 'sshd'
end
