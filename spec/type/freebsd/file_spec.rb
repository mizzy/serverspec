require 'spec_helper'

set :os, :family => 'freebsd'

describe commands.command_class('file').create do
  it { should be_an_instance_of(Specinfra::Command::Freebsd::Base::File) }
end

describe file('/tmp') do
  it { should be_mode 777 }
end
