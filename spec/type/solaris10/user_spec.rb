require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe user('root') do
  it { should have_authorized_key 'XXXXXXXXXXXXXXX' }
end

describe user('root') do
  it { should_not have_authorized_key 'invalid-key' }
end

