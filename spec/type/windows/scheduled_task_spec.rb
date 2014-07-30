require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe windows_scheduled_task('foo') do
  it { should exist }
end
