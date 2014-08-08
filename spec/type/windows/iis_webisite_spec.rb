require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe iis_website('Default Website') do
  it { should exist }
  it { should be_enabled }
  it { should be_running }
  it { should be_in_app_pool('Default App Pool') }
  it { should have_physical_path('C:\\inetpub\\www') } 
  it { should have_site_bindings('port').with_protocol('protocol').with_ipaddress('ipaddress').with_host_header('host_header') }
  it { should have_virtual_dir('vdir').with_path('path') }
  it { should have_site_application('app').with_pool('pool').with_physical_path('physical_path') }
end
