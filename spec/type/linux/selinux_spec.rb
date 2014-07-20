require 'spec_helper'

set :os, :family => 'linux'

describe commands.command_class('selinux').create do
  it { should be_an_instance_of(Specinfra::Command::Linux::Base::Selinux)}
end

describe selinux do
  it { should be_enforcing }
end

describe selinux do
  it { should be_permissive }
end

describe selinux do
  it { should be_disabled }
end
