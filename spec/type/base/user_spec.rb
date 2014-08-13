require 'spec_helper'

set :os, :family => 'base'

describe user('root') do
  it { should exist }
end

describe user('root') do
  it { should belong_to_group 'root' }
end

describe user('root') do
  it { should belong_to_primary_group 'root' }
end

describe user('root') do
  it { should have_uid 0 }
end

describe user('root') do
  it { should have_login_shell '/bin/bash' }
end

describe user('root') do
  it { should have_home_directory '/root' }
end

describe user('root') do
  it { should have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
end
