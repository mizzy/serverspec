require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('package').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::Package) }
end

describe package('foo') do
  it { should be_installed }
end

