require 'spec_helper'

set :os, :family => 'ubuntu'

describe commands.command_class('ppa').create do
  it { should be_an_instance_of(Specinfra::Command::Ubuntu::Base::Ppa) }
end

describe ppa('username/ppa-name') do
  it { should exist }
end

describe ppa('invalid-ppa') do
  it { should_not exist }
end

describe ppa('username/ppa-name') do
  it { should be_enabled }
end

describe ppa('invalid-ppa') do
  it { should_not be_enabled }
end
