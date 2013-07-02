require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec service matchers of Darwin family' do
  it_behaves_like 'support service running matcher', 'sshd'
  it_behaves_like 'support service running under supervisor matcher', 'sshd'
  it_behaves_like 'support service running under unimplemented matcher', 'sshd'
  it_behaves_like 'support service monitored by monit matcher', 'unicorn'
  it_behaves_like 'support service monitored by unimplemented matcher', 'unicorn'
end
