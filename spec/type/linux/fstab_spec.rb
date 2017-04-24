require 'spec_helper'

set :os, :family => 'linux'

describe fstab do
  let(:stdout) { "/dev/sda1 /mnt ext4 ro,errors=remount-ro,barrier=0 0 2\r\n" }
  it { should have_entry( :mount_point => '/mnt' ) }
end

describe fstab do
  let(:exit_status) { 1 }
  it { should_not have_entry( :mount_point => '/mnt' ) }
end

describe fstab do
  let(:stdout) { "/dev/sda1 /mnt ext4 ro,errors=remount-ro,barrier=0 0 2\r\n" }
  it do
    should have_entry(
      :device => '/dev/sda1',
      :mount_point => '/mnt',
      :type => 'ext4',
      :options => {
        :ro => true,
        :errors => 'remount-ro',
        :barrier => 0
      },
      :dump => 0,
      :pass => 2
    )
  end
end
