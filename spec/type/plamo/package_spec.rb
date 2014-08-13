require 'spec_helper'

set :os, :family => 'plamo'

describe package('httpd') do
  it { should be_installed }
end

