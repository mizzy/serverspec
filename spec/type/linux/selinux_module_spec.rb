require 'spec_helper'

set :os, :family => 'linux'

describe selinux_module('bootloader') do
  it { is_expected.to be_installed }
end 

describe selinux_module('bootloader') do
  it { is_expected.to be_installed.with_version('1.10') }
end

describe selinux_module('bootloader') do
  it { is_expected.to be_enabled }
end
