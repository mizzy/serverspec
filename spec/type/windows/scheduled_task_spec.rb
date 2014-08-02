require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe windows_scheduled_task('foo') do
  it { should exist }
end
