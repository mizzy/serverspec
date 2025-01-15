require 'spec_helper'

set :os, :family => 'linux'

describe selinux do
  it { is_expected.to be_enforcing }
end

describe selinux do
  it { is_expected.to be_enforcing.with_policy('mls') }
end

describe selinux do
  it { is_expected.to be_permissive }
end

describe selinux do
  it { is_expected.to be_permissive.with_policy('targeted') }
end

describe selinux do
  it { is_expected.to be_disabled }
end
