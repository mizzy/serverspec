require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec command matchers of Debian family' do
  it_behaves_like 'support command return_stdout matcher', 'cat /etc/resolv.conf', 'localhost'
  it_behaves_like 'support command return_stdout matcher with regexp', 'cat /etc/resolv.conf', /localhost/

  it_behaves_like 'support command return_stderr matcher', 'cat /foo', 'cat: /foo: No such file or directory'
  it_behaves_like 'support command return_stderr matcher with regexp', 'cat /foo', /No such file or directory/

  it_behaves_like 'support command return_exit_status matcher', 'ls /tmp', 0
end
