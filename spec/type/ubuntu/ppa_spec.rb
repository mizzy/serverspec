require 'spec_helper'

set :os, :family => 'ubuntu'

describe ppa('username/ppa-name') do
  it { should exist }
end

describe ppa('invalid-ppa') do
  it { should_not exist }
end

describe ppa('username/ppa-name') do
  it { should be_enabled }
end

describe ppa('invalid-ppa') do
  it { should_not be_enabled }
end
