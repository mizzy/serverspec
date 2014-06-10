require 'spec_helper'

include SpecInfra::Helper::NixOS

describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  its(:command) { should eq "test -f /etc/ssh/sshd_config" }
end

describe file('/etc/invalid_file') do
  it { should_not be_file }
end

describe file('/etc/ssh') do
  it { should be_directory }
  its(:command) { should eq "test -d /etc/ssh" }
end

describe file('/etc/invalid_directory') do
  it { should_not be_directory }
end

describe file('/var/run/unicorn.sock') do
  it { should be_socket }
  its(:command) { should eq "test -S /var/run/unicorn.sock" }
end

describe file('/etc/invalid_socket') do
  it { should_not be_socket }
end

describe file('/etc/ssh/sshd_config') do
  it { should contain 'This is the sshd server system-wide configuration file' }
  its(:command) { should eq "grep -q -- This\\ is\\ the\\ sshd\\ server\\ system-wide\\ configuration\\ file /etc/ssh/sshd_config || grep -qF -- This\\ is\\ the\\ sshd\\ server\\ system-wide\\ configuration\\ file /etc/ssh/sshd_config" }
end

describe file('/etc/ssh/sshd_config') do
  it { should contain /^This is the sshd server system-wide configuration file/ }
  its(:command) { should eq "grep -q -- \\^This\\ is\\ the\\ sshd\\ server\\ system-wide\\ configuration\\ file /etc/ssh/sshd_config || grep -qF -- \\^This\\ is\\ the\\ sshd\\ server\\ system-wide\\ configuration\\ file /etc/ssh/sshd_config" }
end

describe file('/etc/ssh/sshd_config') do
  it { should_not contain 'This is invalid text!!' }
end

describe file('Gemfile') do
  it { should contain('rspec').from(/^group :test do/).to(/^end/) }
  its(:command) { should eq "sed -n /\\^group\\ :test\\ do/,/\\^end/p Gemfile | grep -q -- rspec - || sed -n /\\^group\\ :test\\ do/,/\\^end/p Gemfile | grep -qF -- rspec -" }
end

describe file('/etc/ssh/sshd_config') do
  it { should_not contain('This is invalid text!!').from(/^group :test do/).to(/^end/) }
end

describe file('Gemfile') do
  it { should contain('rspec').after(/^group :test do/) }
  its(:command) { should eq "sed -n /\\^group\\ :test\\ do/,\\$p Gemfile | grep -q -- rspec - || sed -n /\\^group\\ :test\\ do/,\\$p Gemfile | grep -qF -- rspec -" }
end

describe file('/etc/ssh/sshd_config') do
  it { should_not contain('This is invalid text!!').after(/^group :test do/) }
end

describe file('Gemfile') do
  it { should contain('rspec').before(/^end/) }
  its(:command) { should eq "sed -n 1,/\\^end/p Gemfile | grep -q -- rspec - || sed -n 1,/\\^end/p Gemfile | grep -qF -- rspec -" }
end

describe file('/etc/ssh/sshd_config') do
  it { should_not contain('This is invalid text!!').before(/^end/) }
end

describe file('/etc/passwd') do
  it { should be_mode 644 }
  its(:command) { should eq "stat -c %a /etc/passwd | grep -- \\^644\\$" }
end

describe file('/etc/passwd') do
  it { should_not be_mode 'invalid' }
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
  its(:command) { should eq "stat -c %U /etc/passwd | grep -- \\^root\\$" }
end

describe file('/etc/passwd') do
  it { should_not be_owned_by 'invalid-owner' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
  its(:command) { should eq "stat -c %G /etc/passwd | grep -- \\^root\\$" }
end

describe file('/etc/passwd') do
  it { should_not be_grouped_into 'invalid-group' }
end

describe file('/etc/pam.d/system-auth') do
  it { should be_linked_to '/etc/pam.d/system-auth-ac' }
  its(:command) { should eq "stat -c %N /etc/pam.d/system-auth | egrep -e \"-> ./etc/pam.d/system-auth-ac.\"" }
end

describe file('dummy-link') do
  it { should_not be_linked_to '/invalid/target' }
end

describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_readable }
  its(:command) { should eq "stat -c %a /dev" }
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

describe file('/tmp') do
  it { should be_readable.by_user('mail') }
  its(:command) { should eq "su -s /bin/sh -c \"test -r /tmp\" mail" }
end

describe file('/tmp') do
  it { should_not be_readable.by_user('invalid-user') }
end

describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_writable }
  its(:command) { should eq "stat -c %a /dev" }
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

describe file('/tmp') do
  it { should be_writable.by_user('mail') }
  its(:command) { should eq "su -s /bin/sh -c \"test -w /tmp\" mail" }
end

describe file('/tmp') do
  it { should_not be_writable.by_user('invalid-user') }
end

describe file('/dev') do
  let(:stdout) { "755\r\n" }
  it { should be_executable }
  its(:command) { should eq "stat -c %a /dev" }
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

describe file('/tmp') do
  it { should be_executable.by_user('mail') }
  its(:command) { should eq "su -s /bin/sh -c \"test -x /tmp\" mail" }
end

describe file('/tmp') do
  it { should_not be_executable.by_user('invalid-user') }
end

describe file('/') do
  it { should be_mounted }
  its(:command) { should eq "mount | grep -w -- on\\ /" }
end

describe file('/etc/invalid-mount') do
  it { should_not be_mounted }
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

describe file('/etc/invalid-mount') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.with( :type => 'ext4' ) }
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

describe file('/etc/invalid-mount') do
  let(:stdout) { "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n" }
  it { should_not be_mounted.only_with( :type => 'ext4' ) }
end

describe file('/etc/services') do
  it { should match_md5checksum '9d39e51e6bd5a30168c26c57b66d2e37' }
  its(:command) { should eq "md5sum /etc/services | grep -iw -- \\^9d39e51e6bd5a30168c26c57b66d2e37" }
end

describe file('invalid-file') do
  it { should_not match_md5checksum 'INVALIDMD5CHECKSUM' }
end

describe file('/etc/services') do
  it { should match_sha256checksum 'b4d36eb75767bebb41c5fa7a35599952e1883b3d3f6332496e1561eeb4067018' }
  its(:command) { should eq "sha256sum /etc/services | grep -iw -- \\^b4d36eb75767bebb41c5fa7a35599952e1883b3d3f6332496e1561eeb4067018" }
end

describe file('invalid-file') do
  it { should_not match_sha256checksum 'INVALIDSHA256CHECKSUM' }
end

describe file('/etc/passwd') do
  let(:stdout) {<<EOF
root:x:0:0:System administrator:/root:/run/current-system/sw/bin/bash
nscd:x:1:65534:Name service cache daemon user:/var/empty:/run/current-system/sw/sbin/nologin
sshd:x:2:65534:SSH privilege separation user:/var/empty:/run/current-system/sw/sbin/nologin
ntp:x:3:65534:NTP daemon user:/var/lib/ntp:/run/current-system/sw/sbin/nologin
messagebus:x:4:4:D-Bus system message bus daemon user:/var/run/dbus:/run/current-system/sw/sbin/nologin
polkituser:x:28:65534:PolKit daemon:/var/empty:/run/current-system/sw/sbin/nologin
systemd-journal-gateway:x:110:65534::/var/empty:/run/current-system/sw/sbin/nologin
nixbld1:x:30001:30000:Nix build user 1:/var/empty:/run/current-system/sw/sbin/nologin
nixbld2:x:30002:30000:Nix build user 2:/var/empty:/run/current-system/sw/sbin/nologin
nixbld3:x:30003:30000:Nix build user 3:/var/empty:/run/current-system/sw/sbin/nologin
nixbld4:x:30004:30000:Nix build user 4:/var/empty:/run/current-system/sw/sbin/nologin
nixbld5:x:30005:30000:Nix build user 5:/var/empty:/run/current-system/sw/sbin/nologin
nixbld6:x:30006:30000:Nix build user 6:/var/empty:/run/current-system/sw/sbin/nologin
nixbld7:x:30007:30000:Nix build user 7:/var/empty:/run/current-system/sw/sbin/nologin
nixbld8:x:30008:30000:Nix build user 8:/var/empty:/run/current-system/sw/sbin/nologin
nixbld9:x:30009:30000:Nix build user 9:/var/empty:/run/current-system/sw/sbin/nologin
nixbld10:x:30010:30000:Nix build user 10:/var/empty:/run/current-system/sw/sbin/nologin
nobody:x:65534:65534:Unprivileged account (don't use!):/var/empty:/run/current-system/sw/sbin/nologin
EOF
  }

  its(:content) { should match /root:x:0:0/ }
end
