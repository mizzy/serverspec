require 'spec_helper'

set :os, :family => 'linux'

describe linux_kernel_parameter('net.ipv4.tcp_syncookies') do
  let(:stdout) { "1\n" }
  its(:value) { should eq 1 }
end

describe linux_kernel_parameter('net.ipv4.tcp_syncookies') do
  let(:stdout) { "1\n" }
  its(:value) { should_not eq 2 }
end

describe linux_kernel_parameter('kernel.osrelease') do
  let(:stdout) { "2.6.32-131.0.15.el6.x86_64\n" }
  its(:value) { should eq "2.6.32-131.0.15.el6.x86_64" }
end

describe linux_kernel_parameter('kernel.osrelease') do
  let(:stdout) { "2.6.32-131.0.15.el6.x86_64\n" }
  its(:value) { should_not eq "2.6.32-131.0.15.el6.i386" }
end

describe linux_kernel_parameter('net.ipv4.tcp_wmem') do
  let(:stdout) { "4096	16384	4194304\n" }
  its(:value) { should match /16384/ }
end

describe linux_kernel_parameter('net.ipv4.tcp_wmem') do
  let(:stdout) { "4096	16384	4194304\n" }
  its(:value) { should_not match /123456/ }
end
