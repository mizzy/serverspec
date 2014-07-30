require 'spec_helper'

set :os, :family => 'solaris'

describe zfs('rpool') do
  it { should exist }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool'  }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
end
