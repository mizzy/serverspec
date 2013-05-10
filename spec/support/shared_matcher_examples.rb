
shared_examples_for 'support be_enabled matcher' do |valid_service|
  describe 'be_enabled' do
    describe valid_service do
      it { should be_enabled }
    end

    describe 'this-is-invalid-service' do
      it { should_not be_enabled }
    end
  end
end

shared_examples_for 'support be_installed matcher' do |valid_package|
  describe 'be_installed' do
    describe valid_package do
      it { should be_installed }
    end

    describe 'this-is-invalid-package' do
      it { should_not be_installed }
    end
  end
end

shared_examples_for 'support be_running matcher' do |valid_service|
  describe 'be_running' do
    describe valid_service do
      it { should be_running }
    end

    describe 'this-is-invalid-daemon' do
      it { should_not be_running }
    end

    describe valid_service do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} is stopped\r\n"
        end
      end
      it { should be_running }
    end
  end
end

shared_examples_for 'support be_running.under("supervisor") matcher' do |valid_service|
  describe 'be_running.under("supervisor")' do
    describe valid_service do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} RUNNING\r\n"
        end
      end

      it { should be_running.under('supervisor') }
    end

    describe valid_service do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} STOPPED\r\n"
        end
      end

      it { should_not be_running.under('supervisor') }
    end

    describe 'this-is-invalid-daemon' do
      it { should_not be_running.under('supervisor') }
    end
  end
end

shared_examples_for 'support be_running.under("not implemented") matcher' do |valid_service|
  describe 'be_running.under("not implemented")' do
    it {
      expect {
        should be_running.under('not implemented')
      }.to raise_error(ArgumentError, %r/\A`be_running` matcher doesn\'t support/)
    }
  end
end

shared_examples_for 'support be_listening matcher' do |valid_port|
  describe 'be_listening' do
    describe "port #{ valid_port }" do
      it { should be_listening }
    end

    describe 'port invalid' do
      it { should_not be_listening }
    end
  end
end

shared_examples_for 'support be_reachable matcher' do |valid_host|
  describe 'be_reachable' do
    context valid_host do
      it { should be_reachable }
    end

    describe 'invalid-host' do
      it { should_not be_reachable }
    end
  end
end

shared_examples_for 'support be_reachable.with matcher' do |valid_host|
  describe 'be_reachable.with' do
    context valid_host do
      it { should be_reachable.with(:proto => "icmp", :timeout=> 1) }
    end
    context valid_host do
      it { should be_reachable.with(:proto => "tcp", :port => 22, :timeout=> 1) }
    end
    context valid_host do
      it { should be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
    end
    context 'invalid-host' do
      it { should_not be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
    end
  end
end

shared_examples_for 'support be_mounted matcher' do |valid_mount|
  describe 'be_mounted' do
    describe valid_mount do
      it { should be_mounted }
    end

    describe '/etc/thid_is_a_invalid_mount' do
      it { should_not be_mounted }
    end
  end
end

shared_examples_for 'support be_mounted.with matcher' do |valid_mount|
  describe 'be_mounted.with' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n"
      end
    end

    describe valid_mount do
      it { should be_mounted.with( :type => 'ext4' ) }
    end

    describe valid_mount do
      it { should be_mounted.with( :type => 'ext4', :options => { :rw => true } ) }
    end

    describe valid_mount do
      it { should be_mounted.with( :type => 'ext4', :options => { :mode => 620 } ) }
    end

    describe valid_mount do
      it { should be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_root' ) }
    end

    describe valid_mount do
      it { should_not be_mounted.with( :type => 'xfs' ) }
    end

    describe valid_mount do
      it { should_not be_mounted.with( :type => 'ext4', :options => { :rw => false } ) }
    end

    describe valid_mount do
      it { should_not be_mounted.with( :type => 'ext4', :options => { :mode => 600 } ) }
    end

    describe valid_mount do
      it { should_not be_mounted.with( :type => 'xfs', :device => '/dev/mapper/VolGroup-lv_root' ) }
    end

    describe valid_mount do
      it { should_not be_mounted.with( :type => 'ext4', :device => '/dev/mapper/VolGroup-lv_r00t' ) }
    end

    describe '/etc/thid_is_a_invalid_mount' do
      it { should_not be_mounted.with( :type => 'ext4' ) }
    end
  end
end


shared_examples_for 'support be_mounted.only_with matcher' do |valid_mount|
  describe 'be_mounted.with' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "/dev/mapper/VolGroup-lv_root on / type ext4 (rw,mode=620)\r\n"
      end
    end

    describe valid_mount do
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

    describe valid_mount do
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

    describe valid_mount do
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

    describe valid_mount do
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

    describe '/etc/thid_is_a_invalid_mount' do
      it { should_not be_mounted.only_with( :type => 'ext4' ) }
    end
  end
end


shared_examples_for 'support be_resolvable matcher' do |valid_name|
  describe 'be_resolvable' do
    describe valid_name do
      it { should be_resolvable }
    end

    describe 'invalid_name' do
      it { should_not be_resolvable }
    end
  end
end


shared_examples_for 'support be_resolvable.by matcher' do |valid_name, type|
  describe 'be_resolvable.by' do
    describe valid_name do
      it { should be_resolvable.by(type) }
    end

    describe 'invalid_name' do
      it { should_not be_resolvable.by(type) }
    end
  end
end

shared_examples_for 'support be_file matcher' do |valid_file|
  describe 'be_file' do
    describe valid_file do
      it { should be_file }
    end

    describe '/etc/thid_is_invalid_file' do
      it { should_not be_file }
    end
  end
end

shared_examples_for 'support be_directory matcher' do |valid_directory|
  describe 'be_directory' do
    describe valid_directory do
      it { should be_directory }
    end

    describe '/etc/thid_is_invalid_directory' do
      it { should_not be_directory }
    end
  end
end

shared_examples_for 'support contain matcher' do |valid_file, pattern|
  describe 'contain' do
    describe valid_file do
      it { should contain pattern }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain 'This is invalid text!!' }
    end
  end
end

shared_examples_for 'support contain.from.to matcher' do |valid_file, pattern, from, to|
  describe 'contain' do
    describe valid_file do
      it { should contain(pattern).from(from).to(to) }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain('This is invalid text!!').from(from).to(to) }
    end
  end
end

shared_examples_for 'support contain.after matcher' do |valid_file, pattern, after|
  describe 'contain' do
    describe valid_file do
      it { should contain(pattern).after(after) }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain('This is invalid text!!').after(after) }
    end
  end
end

shared_examples_for 'support contain.before matcher' do |valid_file, pattern, before|
  describe 'contain' do
    describe valid_file do
      it { should contain(pattern).before(before) }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain('This is invalid text!!').before(before) }
    end
  end
end

shared_examples_for 'support match_md5checksum matcher' do |valid_file, pattern|
  describe 'match_md5checksum' do
    describe valid_file do
      it { should match_md5checksum pattern }
    end

    describe '/invalid_file' do
      it { should_not match_md5checksum 'INVALIDMD5CHECKSUM' }
    end
  end
end

shared_examples_for 'support be_user matcher' do |valid_user|
  describe 'be_user' do
    describe valid_user do
      it { should be_user }
    end

    describe 'i_am_invalid_user' do
      it { should_not be_user }
    end
  end
end

shared_examples_for 'support be_group matcher' do |valid_group|
  describe 'be_group' do
    describe valid_group do
      it { should be_group }
    end

    describe 'we_are_invalid_group' do
      it { should_not be_group }
    end
  end
end

shared_examples_for 'support be_mode matcher' do |valid_file, mode|
  describe 'be_mode' do
    describe valid_file do
      it { should be_mode mode }
    end

    describe '/etc/passwd' do
      it { should_not be_mode 'invalid' }
    end
  end
end

shared_examples_for 'support be_owned_by matcher' do |valid_file, owner|
  describe 'be_owned_by' do
    describe valid_file do
      it { should be_owned_by owner }
    end

    describe '/etc/passwd' do
      it { should_not be_owned_by 'invalid-owner' }
    end
  end
end

shared_examples_for 'support be_grouped_into matcher' do |valid_file, group|
  describe 'be_grouped_into' do
    describe valid_file do
      it { should be_grouped_into group }
    end

    describe '/etc/passwd' do
      it { should_not be_grouped_into 'invalid-group' }
    end
  end
end

shared_examples_for 'support be_enforcing matcher' do |selinux|
  describe selinux do
    it { should be_enforcing }
  end
end

shared_examples_for 'support be_permissive matcher' do |selinux|
  describe selinux do
    it { should be_permissive }
  end
end

shared_examples_for 'support be_disabled matcher' do |selinux|
  describe selinux do
    it { should be_disabled }
  end
end

shared_examples_for 'support have_cron_entry matcher' do |title, entry|
  describe 'have_cron_entry' do
    describe title do
      it { should have_cron_entry entry }
    end

    describe '/etc/passwd' do
      it { should_not have_cron_entry 'invalid entry' }
    end
  end
end

shared_examples_for 'support have_cron_entry.with_user matcher' do |title, entry, user|
  describe 'have_cron_entry.with_user' do
    describe title do
      it { should have_cron_entry(entry).with_user(user) }
    end

    describe title do
      it { should_not have_cron_entry('dummy entry').with_user('invaliduser') }
    end
  end
end

shared_examples_for 'support be_linked_to matcher' do |file, target|
  describe 'be_linked_to' do
    describe file do
      it { should be_linked_to target }
    end

    describe 'this-is-dummy-link' do
      it { should_not be_linked_to '/invalid/target' }
    end
  end
end

shared_examples_for 'support be_installed.by(gem) matcher' do |name|
  describe 'be_installed.by(gem)' do
    describe name do
      it { should be_installed.by('gem') }
    end

    describe 'invalid-gem' do
      it { should_not be_installed.by('gem') }
    end
  end
end

shared_examples_for 'support be_installed.by(gem).with_version matcher' do |name, version|
  describe 'be_installed.by(gem).with_version' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{name} (#{version})"
      end
    end

    describe name do
      it { should be_installed.by('gem').with_version(version) }
    end

    describe name do
      it { should_not be_installed.by('gem').with_version('invalid-version') }
    end
  end
end

shared_examples_for 'support belong_to_group matcher' do |user, group|
  describe 'belong_to_group' do
    describe user do
      it { should belong_to_group group }
    end

    describe 'dummyuser' do
      it { should_not belong_to_group 'invalid-group' }
    end
  end
end

shared_examples_for 'support have_gid matcher' do |group, gid|
  describe 'have_gid' do
    describe group do
      it { should have_gid gid }
    end

    describe 'dummygroup' do
      it { should_not have_gid 'invalid-gid' }
    end
  end
end

shared_examples_for 'support have_uid matcher' do |user, uid|
  describe 'have_uid' do
    describe user do
      it { should have_uid uid }
    end

    describe 'dummyuser' do
      it { should_not have_uid 'invalid-uid' }
    end
  end
end

shared_examples_for 'support have_login_shell matcher' do |user, path_to_shell|
  describe 'have_login_shell' do
    describe user do
      it { should have_login_shell path_to_shell }
    end

    describe 'dummyuser' do
      it { should_not have_login_shell 'invalid-login-shell' }
    end
  end
end

shared_examples_for 'support have_home_directory matcher' do |user, path_to_home|
  describe 'have_home_directory' do
    describe user do
      it { should have_home_directory path_to_home }
    end

    describe 'dummyuser' do
      it { should_not have_home_directory 'invalid-home-directory' }
    end
  end
end

shared_examples_for 'support have_authorized_key matcher' do |user, key|
  describe 'have_authorized_key' do
    describe user do
      it { should have_authorized_key key }
    end

    describe user do
      it { should_not have_authorized_key 'invalid-publickey' }
    end

    describe 'dummyuser' do
      it { should_not have_authorized_key 'invalid-publickey' }
    end
  end
end

shared_examples_for 'support have_iptables_rule matcher' do |rule|
  describe 'have_iptables_rule' do
    describe 'iptables' do
      it { should have_iptables_rule rule }
    end

    describe 'iptables' do
      it { should_not have_iptables_rule 'invalid-rule' }
    end
  end
end

shared_examples_for 'support have_iptables_rule.with_table.with_chain matcher' do |rule, table, chain|
  describe 'have_iptables_rule.with_table.with_chain' do
    describe 'iptables' do
      it { should have_iptables_rule(rule).with_table(table).with_chain(chain) }
    end

    describe 'iptables' do
      it { should_not have_iptables_rule('invalid-rule').with_table(table).with_chain(chain) }
    end
  end
end

shared_examples_for 'support be_zfs matcher' do |zfs|
  describe 'be_zfs' do
    describe zfs do
      it { should be_zfs }
    end

    describe 'this-is-invalid-zfs' do
      it { should_not be_zfs }
    end
  end
end

shared_examples_for 'support be_zfs.property matcher' do |zfs, property|
  describe 'be_zfs' do
    describe zfs do
      it { should be_zfs.with(property) }
    end

    describe 'this-is-invalid-zfs' do
      it { should_not be_zfs.with(property) }
    end
  end
end

shared_examples_for 'support be_readable matcher' do |file|
  describe 'be_readable' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_readable }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "333\r\n"
        end
      end
      it { should_not be_readable }
    end
  end
end

shared_examples_for 'support be_readable_by_owner matcher' do |file|
  describe 'be_readable_by_owner' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "400\r\n"
        end
      end
      it { should be_readable.by('owner') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "044\r\n"
        end
      end
      it { should_not be_readable.by('owner') }
    end
  end
end

shared_examples_for 'support be_readable_by_group matcher' do |file|
  describe 'be_readable_by_group' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "040\r\n"
        end
      end
      it { should be_readable.by('group') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "404\r\n"
        end
      end
      it { should_not be_readable.by('group') }
    end
  end
end

shared_examples_for 'support be_readable_by_others matcher' do |file|
  describe 'be_readable_by_others' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "044\r\n"
        end
      end
      it { should be_readable.by('others') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "443\r\n"
        end
      end
      it { should_not be_readable.by('others') }
    end
  end
end

shared_examples_for 'support be_writable matcher' do |file|
  describe 'be_writable' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_writable }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable }
    end
  end
end

shared_examples_for 'support be_writable_by_owner matcher' do |file|
  describe 'be_writable_by_owner' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "200\r\n"
        end
      end
      it { should be_writable.by('owner') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('owner') }
    end
  end
end

shared_examples_for 'support be_writable_by_group matcher' do |file|
  describe 'be_writable_by_group' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "030\r\n"
        end
      end
      it { should be_writable.by('group') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('group') }
    end
  end
end

shared_examples_for 'support be_writable_by_others matcher' do |file|
  describe 'be_writable_by_others' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should be_writable.by('others') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "555\r\n"
        end
      end
      it { should_not be_writable.by('others') }
    end
  end
end

shared_examples_for 'support be_executable matcher' do |file|
  describe 'be_executable' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "755\r\n"
        end
      end
      it { should be_executable }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable }
    end
  end
end

shared_examples_for 'support be_executable_by_owner matcher' do |file|
  describe 'be_executable_by_owner' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "100\r\n"
        end
      end
      it { should be_executable.by('owner') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('owner') }
    end
  end
end

shared_examples_for 'support be_executable_by_group matcher' do |file|
  describe 'be_executable_by_group' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "070\r\n"
        end
      end
      it { should be_executable.by('group') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('group') }
    end
  end
end

shared_examples_for 'support be_executable_by_others matcher' do |file|
  describe 'be_executable_by_others' do
    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "001\r\n"
        end
      end
      it { should be_executable.by('others') }
    end

    describe file do
      before :all do
        RSpec.configure do |c|
          c.stdout = "666\r\n"
        end
      end
      it { should_not be_executable.by('others') }
    end
  end
end

shared_examples_for 'support have_ipfilter_rule matcher' do |rule|
  describe 'have_ipfilter_rule' do
    describe 'ipfilter' do
      it { should have_ipfilter_rule rule }
    end

    describe 'ipfilter' do
      it { should_not have_ipfilter_rule 'invalid-rule' }
    end
  end
end

shared_examples_for 'support have_ipnat_rule matcher' do |rule|
  describe 'have_ipnat_rule' do
    describe 'ipnat' do
      it { should have_ipnat_rule rule }
    end

    describe 'ipnat' do
      it { should_not have_ipnat_rule 'invalid-rule' }
    end
  end
end

shared_examples_for 'support have_svcprop.with_value matcher' do |svc, property, value|
  describe 'have_svcprop' do
    describe svc do
      it { should have_svcprop(property).with_value(value) }
    end

    describe 'this-is-invalid-svc' do
      it { should_not have_svcprop(property).with_value(value) }
    end
  end
end

shared_examples_for 'support have_svcprops matcher' do |svc, property|
  describe 'have_svcprop' do
    describe svc do
      it { should have_svcprops(property) }
    end

    describe 'this-is-invalid-svc' do
      it { should_not have_svcprops(property) }
    end
  end
end

shared_examples_for 'support return_exit_status matcher' do |command, status|
  describe 'return_exit_status' do
    describe command do
      it { should return_exit_status(status) }
    end

    describe 'this-is-invalid-command' do
      it { should_not return_exit_status(status) }
    end
  end
end

shared_examples_for 'support return_stdout matcher' do |command, content|
  describe 'return_stdout' do
    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{content}\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foo#{content}bar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end


    describe 'this-is-invalid-command' do
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support return_stdout matcher with regexp' do |command, content|
  describe 'return_stdout' do
    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foo#{content}bar\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foobar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end

    describe 'this-is-invalid-command' do
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support return_stderr matcher' do |command, content|
  describe 'return_stderr' do
    describe command do
      before :all do
        RSpec.configure do |c|
          c.stderr = "#{content}\r\n"
        end
      end
      it { should return_stderr(content) }
    end

    describe command do
      before :all do
        RSpec.configure do |c|
          c.stderr = "No such file or directory\r\n"
        end
      end
      it { should_not return_stderr(content) }
    end
  end
end

shared_examples_for 'support return_stderr matcher with regexp' do |command, content|
  describe 'return_stderr' do
    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "cat: /foo: No such file or directory\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foobar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support linux kernel parameter checking with integer' do |param, value|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}\n"
      end
    end

    context param do
      its(:value) { should eq value }
    end

    context param do
      its(:value) { should_not eq value + 1 }
    end
  end
end

shared_examples_for 'support linux kernel parameter checking with string' do |param, value|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}\n"
      end
    end

    context param do
      its(:value) { should eq value }
    end

    context param do
      its(:value) { should_not eq value + '_suffix' }
    end
  end
end

shared_examples_for 'support linux kernel parameter checking with regexp' do |param, regexp|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "4096	16384	4194304\n"
      end
    end

    context param do
      its(:value) { should match regexp }
    end

    context param do
      its(:value) { should_not match /invalid-string/ }
    end
  end
end
