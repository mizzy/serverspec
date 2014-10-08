require 'spec_helper'

set :os, {:family => 'linux'}
property[:os_by_host] = nil

describe docker_image('i') do
  it { should be_present }
end

describe docker_image('i') do
  let(:stdout) { "amd64\n" }
  it { should have_setting('Architecture','amd64') }
end

describe docker_image('i') do
  let(:stdout) { "amd64\n" }
  its(:Architecture) { should eq 'amd64' }
end

describe docker_container('c') do
  it { should be_present }
end

describe docker_container('c') do
  let(:stdout) { "true\n" }
  it { should be_running }
end

describe docker_container('c') do
  let(:stdout) { "map[/x:/y]\n" }
  it { should have_volume('/x','/y') }
end

describe docker_container('c') do
  let(:stdout) { "true\n" }
  its(:Mangled_Sample_Key) { should eq 'true' }
end

