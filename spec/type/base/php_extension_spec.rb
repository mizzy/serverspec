require 'spec_helper'

set :os, :family => 'base'

describe php_extension('tillext') do
  let(:exit_status) { 1 }
  it { should_not be_loaded }
end

describe php_extension('session') do
  let(:exit_status) { 0 }
  it { should be_loaded }
end
