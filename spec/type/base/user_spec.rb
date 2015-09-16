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

describe user('root') do
  let(:stdout) { "$1$T0aTw9NJ$NdMldLUQ8WqhlEEGToNzl/\n" } 
  its(:encrypted_password) { should eq '$1$T0aTw9NJ$NdMldLUQ8WqhlEEGToNzl/' } 
end

describe user('root') do
  its(:minimum_days_between_password_change) { should == 0 }
end

describe user('root') do
  its(:maximum_days_between_password_change) { should == 0 }
end
