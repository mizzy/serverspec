require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('iis_website').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::IisWebsite) }
end

describe iis_website('Default Website') do
  it{ should exist }
end

describe iis_website('Default Website') do
  it{ should be_enabled }
end

describe iis_website('Default Website') do
  it{ should be_running }
end

describe iis_website('Default Website') do
  it{ should be_in_app_pool('Default App Pool') }
end

describe iis_website('Default Website') do
  it{ should have_physical_path('C:\\inetpub\\www') } 
end

