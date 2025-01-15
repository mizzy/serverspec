require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe iis_website('Default Website') do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
  it { is_expected.to be_running }
  it { is_expected.to be_in_app_pool('Default App Pool') }
  it { is_expected.to have_physical_path('C:\\inetpub\\www') } 
  it { is_expected.to have_site_bindings('port').with_protocol('protocol').with_ipaddress('ipaddress').with_host_header('host_header') }
  it { is_expected.to have_virtual_dir('vdir').with_path('path') }
  it { is_expected.to have_site_application('app').with_pool('pool').with_physical_path('physical_path') }
end
