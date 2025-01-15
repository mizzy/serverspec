require 'spec_helper'

set :os, :family => 'base'

describe user('root') do
  it { is_expected.to exist }
end

describe user('root') do
  it { is_expected.to belong_to_group 'root' }
end

describe user('root') do
  it { is_expected.to belong_to_primary_group 'root' }
end

describe user('root') do
  it { is_expected.to have_uid 0 }
end

describe user('root') do
  its(:uid) { is_expected.to == 0 }
  its(:uid) { is_expected.to < 10 }
end

describe user('root') do
  it { is_expected.to have_login_shell '/bin/bash' }
end

describe user('root') do
  it { is_expected.to have_home_directory '/root' }
end

describe user('root') do
  it { is_expected.to have_authorized_key 'ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH foo@bar.local' }
end

describe user('root') do
  let(:stdout) { "$1$T0aTw9NJ$NdMldLUQ8WqhlEEGToNzl/\n" } 
  its(:encrypted_password) { is_expected.to eq '$1$T0aTw9NJ$NdMldLUQ8WqhlEEGToNzl/' } 
end

describe user('root') do
  its(:minimum_days_between_password_change) { is_expected.to == 0 }
end

describe user('root') do
  its(:maximum_days_between_password_change) { is_expected.to == 0 }
end
