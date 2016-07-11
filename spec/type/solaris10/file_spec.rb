require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe file('/etc/ssh/sshd_config') do
  it { should be_file }
end

describe file('/etc/ssh') do
  it { should be_directory }
end

describe file('/var/run/unicorn.sock') do
  it { should be_socket }
end

describe file('/etc/ssh/sshd_config') do
  it { should contain 'This is the sshd server system-wide configuration file' }
end

describe file('/etc/ssh/sshd_config') do
  it { should contain /^This is the sshd server system-wide configuration file/ }
end

describe file('Gemfile') do
  it { should contain('rspec').from(/^group :test do/).to(/^end/) }
end

describe file('Gemfile') do
  it { should contain('rspec').after(/^group :test do/) }
end

describe file('Gemfile') do
  it { should contain('rspec').before(/^end/) }
end

describe file('/etc/passwd') do
  it { should be_mode 644 }
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
end

describe file('/etc/pam.d/system-auth') do
  it { should be_linked_to '/etc/pam.d/system-auth-ac' }
end

describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_readable }
end

describe file('/dev') do
  let(:stdout) { "333\r\n" }
  it { should_not be_readable }
end

describe file('/dev') do
  let(:stdout) { "400\r\n" }
  it { should be_readable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "044\r\n" }
  it { should_not be_readable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "040\r\n" }
  it { should be_readable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "404\r\n" }
  it { should_not be_readable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "044\r\n" }
  it { should be_readable.by('others') }
end

describe file('/dev') do
  let(:stdout) { "443\r\n" }
  it { should_not be_readable.by('others') }
end

describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_writable }
end

describe file('/dev') do
  let(:stdout) { "555\r\n" }
  it { should_not be_writable }
end

describe file('/dev') do
  let(:stdout) { "200\r\n" }
  it { should be_writable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "555\r\n" }
  it { should_not be_writable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "030\r\n" }
  it { should be_writable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "555\r\n" }
  it { should_not be_writable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "666\r\n" }
  it { should be_writable.by('others') }
end

describe file('/dev') do
  let(:stdout) { "555\r\n" }
  it { should_not be_writable.by('others') }
end


describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_executable }
end

describe file('/dev') do
  let(:stdout) { "666\r\n" }
  it { should_not be_executable }
end

describe file('/dev') do
  let(:stdout) { "100\r\n" }
  it { should be_executable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "666\r\n" }
  it { should_not be_executable.by('owner') }
end

describe file('/dev') do
  let(:stdout) { "070\r\n" }
  it { should be_executable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "666\r\n" }
  it { should_not be_executable.by('group') }
end

describe file('/dev') do
  let(:stdout) { "001\r\n" }
  it { should be_executable.by('others') }
end

describe file('/dev') do
  let(:stdout) { "666\r\n" }
  it { should_not be_executable.by('others') }
end

describe file('/') do
  it { should be_mounted }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should be_mounted.with( :type => 'ext4' ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should be_mounted.with( :type => 'ext4', :options => { :rw => true } ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should be_mounted.with( :type => 'ext4', :options => { :mode => 620 } ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_root' ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'xfs' ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'ext4', :options => { :rw => false } ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'ext4', :options => { :mode => 600 } ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'xfs', :device => '/dev/mapper/VolGroup-lv_root' ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_r00t' ) }
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it do
    should be_mounted.only_with(
      :device  => '/dev/mapper/VolGroup-lv_root',
      :type    => 'ext4',
      :options => {
        :rw   => true,
        :mode => 620,
      }
    )
  end
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it do
    should_not be_mounted.only_with(
      :device  => '/dev/mapper/VolGroup-lv_root',
      :type    => 'ext4',
      :options => {
        :rw   => true,
        :mode => 620,
        :bind => true,
      }
    )
  end
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it do
    should_not be_mounted.only_with(
      :device  => '/dev/mapper/VolGroup-lv_root',
      :type    => 'ext4',
      :options => {
        :rw   => true,
      }
    )
  end
end

describe file('/') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it do
    should_not be_mounted.only_with(
      :device  => '/dev/mapper/VolGroup-lv_roooooooooot',
      :type    => 'ext4',
      :options => {
        :rw   => true,
        :mode => 620,
      }
    )
  end
end

describe file('/etc/services') do
  let(:stdout) { "35435ea447c19f0ea5ef971837ab9ced\n" }
  its(:md5sum) { should eq '35435ea447c19f0ea5ef971837ab9ced' }
end

describe file('/etc/services') do
  let(:stdout)  {"0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a" }
  its(:md5sum) { should eq '0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a' }
end

describe file('/etc/passwd') do
  let(:stdout) {<<EOF
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
EOF
  }

  its(:content) { should match /root:x:0:0/ }
end

describe file('/etc/passwd') do
  it 'be_immutable is not implemented in base class' do
    expect {
      should be_immutable
    }.to raise_error(/is not implemented in Specinfra/)
  end
end
