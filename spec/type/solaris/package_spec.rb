require 'spec_helper'

set :os, :family => 'solaris'

describe package('httpd') do
  it { should be_installed }
end
