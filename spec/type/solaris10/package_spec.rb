require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe commands.command_class('package').create do
  it { should be_an_instance_of(Specinfra::Command::Solaris::V10::Package) }
end

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end
