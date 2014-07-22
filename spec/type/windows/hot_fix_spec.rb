require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('hot_fix').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::HotFix) }
end

describe windows_hot_fix('DESCRIPTION-OR-KB-ID') do
  it { should be_installed }
end

describe windows_hot_fix('DESCRIPTION') do
  it { should be_installed.with_version('KB-ID') }
end

describe windows_hot_fix('DESCRIPTION_WITH_KB123456789_INLINED') do
  it { should be_installed }
end

describe windows_hot_fix('DESCRIPTION_WITH_SUFFIX_KB123456789') do
  it { should be_installed }
end

