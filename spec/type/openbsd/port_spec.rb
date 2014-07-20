require 'spec_helper'

set :os, :family => 'openbsd'

describe commands.command_class('port').create do
  it { should be_an_instance_of(Specinfra::Command::Openbsd::Base::Port) }
end

describe port(80) do
  it { should be_listening }
end
