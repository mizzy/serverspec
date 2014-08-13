require 'spec_helper'

set :os, :family => 'openbsd'

describe user('root') do
  it { should have_login_shell '/bin/bash' }
end

describe user('root') do
  it { should have_home_directory '/root' }
end

