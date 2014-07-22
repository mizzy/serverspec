require 'spec_helper'

set :os, :family => 'linux'

describe commands.command_class('kernel_module').create do
  it { should be_an_instance_of(Specinfra::Command::Linux::Base::KernelModule) }
end

describe kernel_module('lp') do
  it { should be_loaded }
end

describe kernel_module('invalid-module') do
  it { should_not be_loaded }
end
