require 'spec_helper'

set :os, :family => 'arch'

describe package('httpd') do
  it { is_expected.to be_installed }
end

describe package('httpd') do
  it { is_expected.to be_installed.with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  let(:stdout) { "2.2.15\n" }
  its(:version) { is_expected.to eq '2.2.15' }
  its(:version) { is_expected.to > '2.2.14' }
  its(:version) { is_expected.to < '2.2.16' }
  its(:version) { is_expected.to > '2.2.9' }
end
