require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe user('root') do
  it { is_expected.to have_authorized_key 'XXXXXXXXXXXXXXX' }
end

