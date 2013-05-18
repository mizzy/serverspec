shared_examples_for 'support file be_file matcher' do |name|
  describe 'be_file' do
    describe file(name) do
      it { should be_file }
    end

    describe file('/etc/invalid_file') do
      it { should_not be_file }
    end
  end
end

shared_examples_for 'support file be_directory matcher' do |name|
  describe 'be_directory' do
    describe file(name) do
      it { should be_directory }
    end

    describe file('/etc/invalid_directory') do
      it { should_not be_directory }
    end
  end
end

shared_examples_for 'support file contain matcher' do |name, pattern|
  describe 'contain' do
    describe file(name) do
      it { should contain pattern }
    end

    describe file('/etc/ssh/sshd_config') do
      it { should_not contain 'This is invalid text!!' }
    end
  end
end

shared_examples_for 'support file contain from to matcher' do |name, pattern, from, to|
  describe 'contain' do
    describe file(name) do
      it { should contain(pattern).from(from).to(to) }
    end

    describe file('/etc/ssh/sshd_config') do
      it { should_not contain('This is invalid text!!').from(from).to(to) }
    end
  end
end

shared_examples_for 'support file contain after matcher' do |name, pattern, after|
  describe 'contain' do
    describe file(name) do
      it { should contain(pattern).after(after) }
    end

    describe file('/etc/ssh/sshd_config') do
      it { should_not contain('This is invalid text!!').after(after) }
    end
  end
end

shared_examples_for 'support file contain before matcher' do |name, pattern, before|
  describe 'contain' do
    describe file(name) do
      it { should contain(pattern).before(before) }
    end

    describe file('/etc/ssh/sshd_config') do
      it { should_not contain('This is invalid text!!').before(before) }
    end
  end
end

shared_examples_for 'support file be_mode matcher' do |name, mode|
  describe 'be_mode' do
    describe file(name) do
      it { should be_mode mode }
    end

    describe file('/etc/passwd') do
      it { should_not be_mode 'invalid' }
    end
  end
end

shared_examples_for 'support file be_owned_by matcher' do |name, owner|
  describe 'be_owned_by' do
    describe file(name) do
      it { should be_owned_by owner }
    end

    describe file('/etc/passwd') do
      it { should_not be_owned_by 'invalid-owner' }
    end
  end
end

shared_examples_for 'support file be_grouped_into matcher' do |name, group|
  describe 'be_grouped_into' do
    describe file(name) do
      it { should be_grouped_into group }
    end

    describe file('/etc/passwd') do
      it { should_not be_grouped_into 'invalid-group' }
    end
  end
end

shared_examples_for 'support file be_linked_to matcher' do |name, target|
  describe 'be_linked_to' do
    describe file(name) do
      it { should be_linked_to target }
    end

    describe file('dummy-link') do
      it { should_not be_linked_to '/invalid/target' }
    end
  end
end

shared_examples_for 'support file be_readable matcher' do |name|
  describe 'be_readable' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_readable }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "333\r\n"
        end
      end
      it { should_not be_readable }
    end
  end
end

shared_examples_for 'support file be_readable by owner matcher' do |name|
  describe 'be_readable by owner' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "400\r\n"
        end
      end
      it { should be_readable.by('owner') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "044\r\n"
        end
      end
      it { should_not be_readable.by('owner') }
    end
  end
end

shared_examples_for 'support file be_readable by group matcher' do |name|
  describe 'be_readable by group' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "040\r\n"
        end
      end
      it { should be_readable.by('group') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "404\r\n"
        end
      end
      it { should_not be_readable.by('group') }
    end
  end
end

shared_examples_for 'support file be_readable by others matcher' do |name|
  describe 'be_readable by others' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "044\r\n"
        end
      end
      it { should be_readable.by('others') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "443\r\n"
        end
      end
      it { should_not be_readable.by('others') }
    end
  end
end

shared_examples_for 'support file be_readable by specific user matcher' do |name, user|
  describe 'be_readable by specific user' do
    describe file(name) do
      it { should be_readable.by_user(user) }
    end
    describe file(name) do
      it { should_not be_readable.by_user('invalid-user') }
    end
  end
end

shared_examples_for 'support file be_writable matcher' do |name|
  describe 'be_writable' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_writable }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable }
    end
  end
end

shared_examples_for 'support file be_writable by owner matcher' do |name|
  describe 'be_writable_by_owner' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "200\r\n"
        end
      end
      it { should be_writable.by('owner') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('owner') }
    end
  end
end

shared_examples_for 'support file be_writable by group matcher' do |name|
  describe 'be_writable_by_group' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "030\r\n"
        end
      end
      it { should be_writable.by('group') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('group') }
    end
  end
end

shared_examples_for 'support file be_writable by others matcher' do |name|
  describe 'be_writable_by_others' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should be_writable.by('others') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('others') }
    end
  end
end

shared_examples_for 'support file be_writable by specific user matcher' do |name, user|
  describe 'be_writable by specific user' do
    describe file(name) do
      it { should be_writable.by_user(user) }
    end
    describe file(name) do
      it { should_not be_writable.by_user('invalid-user') }
    end
  end
end

shared_examples_for 'support file be_executable matcher' do |name|
  describe 'be_executable' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_executable }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable }
    end
  end
end

shared_examples_for 'support file be_executable by owner matcher' do |name|
  describe 'be_executable by owner' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "100\r\n"
        end
      end
      it { should be_executable.by('owner') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('owner') }
    end
  end
end

shared_examples_for 'support file be_executable by group matcher' do |name|
  describe 'be_executable by group' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "070\r\n"
        end
      end
      it { should be_executable.by('group') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('group') }
    end
  end
end

shared_examples_for 'support file be_executable by others matcher' do |name|
  describe 'be_executable by others' do
    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "001\r\n"
        end
      end
      it { should be_executable.by('others') }
    end

    describe file(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('others') }
    end
  end
end

shared_examples_for 'support file be_executable by specific user matcher' do |name, user|
  describe 'be_writable by specific user' do
    describe file(name) do
      it { should be_executable.by_user(user) }
    end
    describe file(name) do
      it { should_not be_executable.by_user('invalid-user') }
    end
  end
end

shared_examples_for 'support file be_mounted matcher' do |name|
  describe 'be_mounted' do
    describe file(name) do
      it { should be_mounted }
    end

    describe file('/etc/invalid-mount') do
      it { should_not be_mounted }
    end
  end
end

shared_examples_for 'support file be_mounted with matcher' do |name|
  describe 'be_mounted.with' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n"
      end
    end

    describe file(name) do
      it { should be_mounted.with( :type => 'ext4' ) }
    end

    describe file(name) do
      it { should be_mounted.with( :type => 'ext4', :options => { :rw => true } ) }
    end

    describe file(name) do
      it { should be_mounted.with( :type => 'ext4', :options => { :mode => 620 } ) }
    end

    describe file(name) do
      it { should be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_root' ) }
    end

    describe file(name) do
      it { should_not be_mounted.with( :type => 'xfs' ) }
    end

    describe file(name) do
      it { should_not be_mounted.with( :type => 'ext4', :options => { :rw => false } ) }
    end

    describe file(name) do
      it { should_not be_mounted.with( :type => 'ext4', :options => { :mode => 600 } ) }
    end

    describe file(name) do
      it { should_not be_mounted.with( :type => 'xfs', :device => '/dev/mapper/VolGroup-lv_root' ) }
    end

    describe file(name) do
      it { should_not be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_r00t' ) }
    end

    describe file('/etc/invalid-mount') do
      it { should_not be_mounted.with( :type => 'ext4' ) }
    end
  end
end


shared_examples_for 'support file be_mounted only with matcher' do |name|
  describe 'be_mounted.with' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n"
      end
    end

    describe file(name) do
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

    describe file(name) do
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

    describe file(name) do
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

    describe file(name) do
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
      it { should_not be_mounted.only_with( :type => 'ext4' ) }
    end
  end
end

shared_examples_for 'support file match_md5checksum matcher' do |name, pattern|
  describe 'match_md5checksum' do
    describe file(name) do
      it { should match_md5checksum pattern }
    end

    describe file('invalid-file') do
      it { should_not match_md5checksum 'INVALIDMD5CHECKSUM' }
    end
  end
end
