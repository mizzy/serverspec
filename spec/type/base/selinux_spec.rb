require 'spec_helper'

set :os, :family => 'base'

describe selinux do
  it { should be_enforcing }
end

describe selinux do
  it { should be_permissive }
end

describe selinux do
  it { should be_disabled }
end
