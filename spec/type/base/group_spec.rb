require 'spec_helper'

set :os, :family => 'base'

describe group('root') do
  it { should exist }
end

describe group('root') do
  it { should have_gid 0 }
end

describe group('root') do
  its(:gid) { should == 0 }
  its(:gid) { should < 10 }
end

describe group('root') do
  it { should be_is_system_group }
end
