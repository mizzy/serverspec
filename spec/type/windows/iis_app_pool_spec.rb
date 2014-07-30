require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe iis_app_pool('Default App Pool') do
  it{ should exist }
end

describe iis_app_pool('Default App Pool') do
  it{ should have_dotnet_version('2.0') }
end

