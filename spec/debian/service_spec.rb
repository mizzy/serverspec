require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec service matchers of Red Hat family' do
  it_behaves_like 'support service enabled matcher', 'sshd'
  it_behaves_like 'support service enabled with level matcher', 'sshd', 3
  it_behaves_like 'support service running matcher', 'sshd'
  it_behaves_like 'support service running under supervisor matcher', 'sshd'
  it_behaves_like 'support service running under upstart matcher', 'monit'
  it_behaves_like 'support service running under unimplemented matcher', 'sshd'
end
