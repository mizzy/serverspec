require 'spec_helper'

set :os, :family => 'openbsd'

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

