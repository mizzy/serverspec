require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe iis_app_pool('Default App Pool') do
  it { should exist }
  it { should have_dotnet_version('2.0') }
  it { should have_32bit_enabled }
  it { should have_idle_timeout(5) }
  it { should have_identity_type('foo') }
  it { should have_periodic_restart(60) }
  it { should have_user_profile_enabled }
  it { should have_username('user') }
  it { should have_managed_pipeline_mode('mode') }
end
