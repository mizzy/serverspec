require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end
