require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec service matchers of Darwin family' do
  it_behaves_like 'support service running matcher', 'sshd'
  it_behaves_like 'support service running under supervisor matcher', 'sshd'
  it_behaves_like 'support service running under unimplemented matcher', 'sshd'
end
