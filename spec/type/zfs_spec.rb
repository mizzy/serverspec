require 'spec_helper'

include Specinfra::Helper::RedHat

describe zfs('rpool') do
  it { should exist }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool'  }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
end
