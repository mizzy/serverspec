require 'spec_helper'

set :os, :family => 'openbsd'

describe user('root') do
  it { is_expected.to have_login_shell '/bin/bash' }
end

describe user('root') do
  it { is_expected.to have_home_directory '/root' }
end

