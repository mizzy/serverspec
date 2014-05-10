require 'spec_helper'

include SpecInfra::Helper::Gentoo

describe process("memcached") do
  let(:stdout) { " 1407\n" }
  its(:pid) { should eq 1407 }
  its(:command) { should eq "ps -C memcached -o pid= | head -1" }
end

describe process("memcached") do
  let(:stdout) { "/usr/bin/memcached -m 14386 -p 11211 -u nobody -l 10.11.1.53 -c 30000\n" }
  its(:args) { should match /-c 30000\b/ }
  its(:command) { should eq "ps -C memcached -o args= | head -1" }
end

describe process("memcached") do
  context "when running" do
    let(:stdout) { " 1407\n" }
    it { should be_running }
    its(:command) { should eq "ps -C memcached -o pid= | head -1" }
  end

  context "when not running" do
    let(:stdout) { " 1407\n" }
    it { should be_running }
    its(:command) { should eq "ps -C memcached -o pid= | head -1" }
  end
end
