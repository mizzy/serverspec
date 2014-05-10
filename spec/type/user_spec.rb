require 'spec_helper'

include Specinfra::Helper::RedHat

describe user('root') do
  it { should exist }
end

describe user('invalid-user') do
  it { should_not exist }
end

describe user('root') do
  it { should belong_to_group 'root' }
end

describe user('root') do
  it { should_not belong_to_group 'invalid-group' }
end

describe user('root') do
  it { should have_uid 0 }
end

describe user('root') do
  it { should_not have_uid 'invalid-uid' }
end

describe user('root') do
  it { should have_login_shell '/bin/bash' }
end

describe user('root') do
  it { should_not have_login_shell 'invalid-login-shell' }
end

describe user('root') do
  it { should have_home_directory '/root' }
end

describe user('root') do
  it { should_not have_home_directory 'invalid-home-directory' }
end

describe user('root') do
  it { should have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
end

describe user('root') do
  it { should_not have_authorized_key 'invalid-key' }
end
