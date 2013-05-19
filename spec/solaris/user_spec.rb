require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec user matchers of Solaris family' do
  it_behaves_like 'support user exist matcher', 'root'
  it_behaves_like 'support user belong_to_group matcher', 'root', 'root'
  it_behaves_like 'support user have_uid matcher', 'root', 0
  it_behaves_like 'support user have_login_shell matcher', 'root', '/bin/bash'
  it_behaves_like 'support user have_home_directory matcher', 'root', '/root'
  it_behaves_like 'support user have_authorized_key matcher', 'root', 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local'
end
