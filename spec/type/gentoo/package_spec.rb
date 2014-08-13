require 'spec_helper'

set :os, :family => 'gentoo'

describe package('httpd') do
  it { should be_installed }
end
