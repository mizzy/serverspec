require 'spec_helper'

set :os, :family => 'aix'

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end
