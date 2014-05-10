require 'spec_helper'

include SpecInfra::Helper::FreeBSD

describe user('root') do
  it { should exist }
  its(:command) { should eq "id root" }
end

describe user('invalid-user') do
  it { should_not exist }
end

describe user('root') do
  it { should belong_to_group 'root' }
  its(:command) { should eq "id root | awk '{print $3}' | grep -- root" }
end

describe user('root') do
  it { should_not belong_to_group 'invalid-group' }
end

describe user('root') do
  it { should have_uid 0 }
  its(:command) { should eq "id root | grep -- \\^uid\\=0\\(" }
end

describe user('root') do
  it { should_not have_uid 'invalid-uid' }
end

describe user('root') do
  it { should have_login_shell '/bin/bash' }
  its(:command) { should eq "getent passwd root | cut -f 7 -d ':' | grep -w -- /bin/bash" }
end

describe user('root') do
  it { should_not have_login_shell 'invalid-login-shell' }
end

describe user('root') do
  it { should have_home_directory '/root' }
  its(:command) { should eq "getent passwd root | cut -f 6 -d ':' | grep -w -- /root" }
end

describe user('root') do
  it { should_not have_home_directory 'invalid-home-directory' }
end

describe user('root') do
  it { should have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
  its(:command) { should eq "grep -w -- ssh-rsa\\ ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH ~root/.ssh/authorized_keys" }
end

describe user('root') do
  it { should_not have_authorized_key 'invalid-key' }
end
