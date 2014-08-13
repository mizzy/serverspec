require 'spec_helper'

set :os, :family => 'base'

describe group('root') do
  it { should exist }
end

describe group('root') do
  it { should have_gid 0 }
end
