require 'spec_helper'

set :os, :family => 'base'

describe process("memcached") do
  let(:stdout) { " 1407\n" }
  its(:pid) { is_expected.to eq 1407 }
end

describe process("memcached") do
  let(:stdout) { "/usr/bin/memcached -m 14386 -p 11211 -u nobody -l 10.11.1.53 -c 30000\n" }
  its(:args) { is_expected.to match /-c 30000\b/ }
end

describe process("memcached") do
  let(:stdout) { "nobody\n" }
  its(:user)  { is_expected.to eq "nobody" }
end

describe process("memcached") do
  let(:stdout) { "nobody\n" }
  its(:group)  { is_expected.to eq "nobody" }
end

describe process("memcached") do
  context "when running" do
    let(:stdout) { " 1407\n" }
    it { is_expected.to be_running }
  end

  context "when not running" do
    let(:stdout) { " 1407\n" }
    it { is_expected.to be_running }
  end
end
