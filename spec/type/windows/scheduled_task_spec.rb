require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('scheduled_task').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::ScheduledTask) }
end

describe windows_scheduled_task('foo') do
  it { should exist }
end
