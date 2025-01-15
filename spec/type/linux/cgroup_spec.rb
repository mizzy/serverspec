require 'spec_helper'

set :os, :family => 'linux'

describe cgroup('group1') do
  let(:stdout) { "1\r\n" }
  its('cpuset.cpus') { is_expected.to eq 1 }
end

describe cgroup('group1') do
  let(:stdout) { "1\r\n" }
  its('cpuset.cpus') { is_expected.to_not eq 0 }
end
