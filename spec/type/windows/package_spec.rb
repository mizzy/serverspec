require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe package('foo') do
  it { is_expected.to be_installed }
end

