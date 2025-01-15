require 'spec_helper'

set :os, :family => 'plamo'

describe package('httpd') do
  it { is_expected.to be_installed }
end

