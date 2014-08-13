require 'spec_helper'

set :os, :family => 'redhat'

describe package('httpd') do
  it { should be_installed }
end

describe package('httpd') do
  it { should be_installed.with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  it { should be_installed.by('rpm').with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  let(:stdout) { "2.2.15\n" }
  its(:version) { should eq '2.2.15' }
  its(:version) { should > '2.2.14' }
  its(:version) { should < '2.2.16' }
  its(:version) { should > '2.2.9' }
end
