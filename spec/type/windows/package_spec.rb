require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe package('foo') do
  it { should be_installed }
end

