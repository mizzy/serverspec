require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe package('foo') do
  it { should be_installed }
end

