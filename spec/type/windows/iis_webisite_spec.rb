require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

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

