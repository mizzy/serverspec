require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('iis_app_pool').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::IisAppPool) }
end

describe iis_app_pool('Default App Pool') do
  it{ should exist }
end

describe iis_app_pool('Default App Pool') do
  it{ should have_dotnet_version('2.0') }
end

