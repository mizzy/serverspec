require 'spec_helper'

set :os, :family => 'aix'

describe group('root') do
  it { should have_gid 0 }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
