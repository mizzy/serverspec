require 'spec_helper'

set :os, :family => 'linux'

describe bridge('br0') do
  it { should exist }
end

describe bridge('br0') do
  let(:stdout) { 'eth0' }
  it { should have_interface 'eth0' }
end
