require 'spec_helper'

set :os, :family => 'aix'

describe port(80) do
  it { is_expected.to be_listening }
end

describe port(80) do
  it { is_expected.to be_listening.with('tcp') }
end

describe port(80) do
  it { is_expected.to be_listening.on('127.0.0.1') }
end

describe port(53) do
  it { is_expected.to be_listening.with('udp') }
end

