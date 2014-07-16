require 'spec_helper'

set :os, :family => 'base'

describe process("memcached") do
  let(:stdout) { " 1407\n" }
  its(:pid) { should eq 1407 }
end

describe process("memcached") do
  let(:stdout) { "/usr/bin/memcached -m 14386 -p 11211 -u nobody -l 10.11.1.53 -c 30000\n" }
  its(:args) { should match /-c 30000\b/ }
end

describe process("memcached") do
  let(:stdout) { "nobody\n" }
  its(:user)  { should eq "nobody" }
end

describe process("memcached") do
  let(:stdout) { "nobody\n" }
  its(:group)  { should eq "nobody" }
end

describe process("memcached") do
  context "when running" do
    let(:stdout) { " 1407\n" }
    it { should be_running }
  end

  context "when not running" do
    let(:stdout) { " 1407\n" }
    it { should be_running }
  end
end
