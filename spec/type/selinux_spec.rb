require 'spec_helper'

include Specinfra::Helper::RedHat

describe selinux do
  it { should be_enforcing }
end

describe selinux do
  it { should be_permissive }
end

describe selinux do
  it { should be_disabled }
end
