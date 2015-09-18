require 'spec_helper'

set :os, :family => 'linux'

describe selinux do
  it { should be_enforcing }
end

describe selinux do
  it { should be_enforcing.with_policy('mls') }
end

describe selinux do
  it { should be_permissive }
end

describe selinux do
  it { should be_permissive.with_policy('targeted') }
end

describe selinux do
  it { should be_disabled }
end
