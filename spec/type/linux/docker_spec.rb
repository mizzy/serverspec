require 'spec_helper'

set :os, {:family => 'linux'}
property[:os_by_host] = nil

describe docker_image('i') do
  it { should exist }
end

describe docker_image('i') do
  let(:stdout) { "amd64\n" }
  its(:architecture) { should eq 'amd64' }
end

describe docker_container('c') do
  it { should exist }
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
  let(:stdout) { "map[/x:/y]\n" }
  it { should have_volume('/x') }
end

describe docker_container('c') do
  let(:stdout) { "true\n" }
  its(:mangled_sample_key) { should eq 'true' }
end

