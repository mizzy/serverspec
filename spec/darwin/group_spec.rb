require 'spec_helper'

RSpec.configure do |c|
  c.os = 'Darwin'
end

describe group('root') do
  it { should exist }
  its(:command) { should eq "getent group | grep -wq -- root" }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('root') do
  it { should have_gid 0 }
  its(:command) { should eq "getent group | grep -w -- \\^root | cut -f 3 -d ':' | grep -w -- 0" }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
