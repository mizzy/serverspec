require 'spec_helper'

set :os, :family => 'openbsd'

describe package('httpd') do
  it { should be_installed }
end

describe package('httpd') do
  it { should be_installed.with_version('2.2.15-28.el6') }
end
