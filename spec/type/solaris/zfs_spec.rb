require 'spec_helper'

set :os, :family => 'solaris'

describe zfs('rpool') do
  it { is_expected.to exist }
end

describe zfs('rpool') do
  it { is_expected.to have_property 'mountpoint' => '/rpool'  }
end

describe zfs('rpool') do
  it { is_expected.to have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
end
