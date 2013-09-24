require 'spec_helper'

RSpec.configure do |c|
  c.os = 'Solaris11'
end

describe zfs('rpool') do
  it { should exist }
  its(:command) { should eq "zfs list -H rpool" }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool'  }
  its(:command) { should eq "zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
end

describe zfs('rpool') do
  it { should have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
  its(:command) { should eq "zfs list -H -o compression rpool | grep -- \\^off\\$ && zfs list -H -o mountpoint rpool | grep -- \\^/rpool\\$" }
end
