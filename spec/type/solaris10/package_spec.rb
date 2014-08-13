require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe package('httpd') do
  it { should be_installed }
end

