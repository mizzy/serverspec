require 'spec_helper'

set :os, :family => 'gentoo'

describe package('httpd') do
  it { is_expected.to be_installed }
end
