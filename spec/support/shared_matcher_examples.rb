
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

shared_examples_for 'support be_installed_by_gem matcher' do |name|
  describe 'be_installed_by_gem' do
    describe name do
      it { should be_installed_by_gem }
    end

    describe 'invalid-gem' do
      it { should_not be_installed_by_gem }
    end
  end
end

shared_examples_for 'support be_installed_by_gem.with_version matcher' do |name, version|
  describe 'be_installed_by_gem.with_version' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{name} (#{version})"
      end
    end

    describe name do
      it { should be_installed_by_gem.with_version(version) }
    end

    describe name do
      it { should_not be_installed_by_gem.with_version('invalid-version') }
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

shared_examples_for 'support get_stdout matcher' do |command, output|
  before :all do
    RSpec.configure do |c|
      c.stdout = "#{output}\r\n"
    end
  end

  describe command do
    it { should get_stdout output }
  end

  describe command do
    it { should_not get_stdout 'invalid-output' }
  end
end
