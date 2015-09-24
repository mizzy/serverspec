require 'spec_helper'

set :os, :family => 'aix'

describe user('root') do
  it { should belong_to_group 'root' }
end

describe user('root') do
  it 'have_login_shell is not implemented' do
    expect {
      should have_login_shell '/bin/bash'
    }.to raise_exception(NotImplementedError)
  end
end

describe user('root') do
  it 'have_home_directory is not implemented' do
    expect {
      should have_home_directory '/root'
    }.to raise_exception(NotImplementedError)
  end
end
