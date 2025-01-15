require 'spec_helper'

set :os, :family => 'ubuntu'

describe ppa('username/ppa-name') do
  it { is_expected.to exist }
end

describe ppa('username/ppa-name') do
  it { is_expected.to be_enabled }
end
