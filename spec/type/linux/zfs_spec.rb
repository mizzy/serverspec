require 'spec_helper'

set :os, :family => 'linux'

describe commands.command_class('zfs') do
  it { should be_an_instance_of(Specinfra::Command::Linux::Base::Zfs) }
end

describe zfs('rpool') do
  it { should exist }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool'  }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
end
