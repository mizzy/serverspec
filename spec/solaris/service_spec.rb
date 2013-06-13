require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec service matchers of Solaris' do
  it_behaves_like 'support service enabled matcher', 'sshd'
  it_behaves_like 'support service running matcher', 'sshd'
  it_behaves_like 'support service running under supervisor matcher', 'sshd'
  it_behaves_like 'support service running under unimplemented matcher', 'sshd'
end
