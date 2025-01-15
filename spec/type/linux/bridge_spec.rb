require 'spec_helper'

set :os, :family => 'linux'

describe bridge('br0') do
  it { is_expected.to exist }
end

describe bridge('br0') do
  let(:stdout) { 'eth0' }
  it { is_expected.to have_interface 'eth0' }
end
