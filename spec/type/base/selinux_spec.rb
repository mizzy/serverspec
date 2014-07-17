require 'spec_helper'

set :os, :family => 'base'

describe selinux do
  xit { should be_enforcing }
end

describe selinux do
  xit { should be_permissive }
end

describe selinux do
  xit { should be_disabled }
end
