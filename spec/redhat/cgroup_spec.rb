require 'spec_helper'

include SpecInfra::Helper::RedHat

describe cgroup('group1') do
  let(:stdout) { "1\r\n" }
  its('cpuset.cpus') { should eq 1 }
  its(:command) { should eq "cgget -n -r cpuset.cpus group1 | awk '{print $2}'" }
end

describe cgroup('group1') do
  let(:stdout) { "1\r\n" }
  its('cpuset.cpus') { should_not eq 0 }
end
