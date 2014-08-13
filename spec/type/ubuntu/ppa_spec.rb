require 'spec_helper'

set :os, :family => 'ubuntu'

describe ppa('username/ppa-name') do
  it { should exist }
end

describe ppa('username/ppa-name') do
  it { should be_enabled }
end
