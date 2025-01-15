require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe package('httpd') do
  it { is_expected.to be_installed }
end

