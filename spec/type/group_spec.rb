require 'spec_helper'

set :os, :family => 'redhat'

describe group('root') do
  it { should exist }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('root') do
  it { should have_gid 0 }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
