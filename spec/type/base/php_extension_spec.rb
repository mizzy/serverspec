require 'spec_helper'

set :os, :family => 'base'

describe php_extension('tillext') do
  let(:exit_status) { 1 }
  it { is_expected.to_not be_loaded }
end

describe php_extension('session') do
  let(:exit_status) { 0 }
  it { is_expected.to be_loaded }
end
