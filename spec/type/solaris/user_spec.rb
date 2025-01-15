require 'spec_helper'

set :os, :family => 'solaris'

describe user('root') do
  it { is_expected.to belong_to_group 'root' }
end

describe user('root') do
  it { is_expected.to have_login_shell '/bin/bash' }
end

describe user('root') do
  it { is_expected.to have_home_directory '/root' }
end

