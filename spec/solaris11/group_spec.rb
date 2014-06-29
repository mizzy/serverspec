require 'spec_helper'

include SpecInfra::Helper::Solaris11

describe group('root') do
  it { should exist }
  its(:command) { should eq "getent group root" }
end

describe group('invalid-group') do
  it { should_not exist }
end

describe group('root') do
  it { should have_gid 0 }
  its(:command) { should eq "getent group | grep -- \\^root: | cut -f 3 -d ':' | grep -w -- 0" }
end

describe group('root') do
  it { should_not have_gid 'invalid-gid' }
end
