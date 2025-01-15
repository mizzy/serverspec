require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe iis_app_pool('Default App Pool') do
  it { is_expected.to exist }
  it { is_expected.to have_dotnet_version('2.0') }
  it { is_expected.to have_32bit_enabled }
  it { is_expected.to have_idle_timeout(5) }
  it { is_expected.to have_identity_type('foo') }
  it { is_expected.to have_periodic_restart(60) }
  it { is_expected.to have_user_profile_enabled }
  it { is_expected.to have_username('user') }
  it { is_expected.to have_managed_pipeline_mode('mode') }
end
