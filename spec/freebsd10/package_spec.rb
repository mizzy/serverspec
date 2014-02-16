require 'spec_helper'

include SpecInfra::Helper::FreeBSD10

describe package('httpd') do
  it { should be_installed }
  its(:command) { should eq "pkg info httpd" }
end

describe package('httpd') do
  it { should be_installed.with_version('2.2.15-28.el6') }
  its(:command) { should eq "pkg query %v httpd | grep -- 2.2.15-28.el6"}
end
