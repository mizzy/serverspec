require 'spec_helper'

set :os, {:family => 'openbsd'}

describe commands.command_class('file').create do
  it { should be_an_instance_of(Specinfra::Command::Openbsd::Base::File) }
end

describe file('/etc/passwd') do
  it { should be_mode 644 }
end

describe file('/etc/passwd') do
  it { should_not be_mode 'invalid' }
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { should_not be_owned_by 'invalid-owner' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
end

describe file('/etc/passwd') do
  it { should_not be_grouped_into 'invalid-group' }
end

describe file('/etc/pam.d/system-auth') do
  it { should be_linked_to '/etc/pam.d/system-auth-ac' }
end

describe file('dummy-link') do
  it { should_not be_linked_to '/invalid/target' }
end

describe file('/') do
  it { should be_mounted }
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
  it { should match_md5checksum '35435ea447c19f0ea5ef971837ab9ced' }
end

describe file('invalid-file') do
  it { should_not match_md5checksum 'INVALIDMD5CHECKSUM' }
end

describe file('/etc/services') do
  it { should match_sha256checksum '0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a' }
end

describe file('invalid-file') do
  it { should_not match_sha256checksum 'INVALIDSHA256CHECKSUM' }
end
