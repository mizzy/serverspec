require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe windows_hot_fix('DESCRIPTION-OR-KB-ID') do
  it { is_expected.to be_installed }
end

describe windows_hot_fix('DESCRIPTION') do
  it { is_expected.to be_installed.with_version('KB-ID') }
end

describe windows_hot_fix('DESCRIPTION_WITH_KB123456789_INLINED') do
  it { is_expected.to be_installed }
end

describe windows_hot_fix('DESCRIPTION_WITH_SUFFIX_KB123456789') do
  it { is_expected.to be_installed }
end

