require 'spec_helper'

set :os, :family => 'solaris'

describe commands.command_class('package').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::Base::Package) }
end

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end
