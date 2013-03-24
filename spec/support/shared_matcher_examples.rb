
shared_examples_for 'support be_enabled matcher' do |valid_service|
  describe 'be_enabled' do
    describe valid_service do
      it { should be_enabled }
    end

    describe 'this-is-dummy-service' do
      it { should_not be_enabled }
    end
  end
end

shared_examples_for 'support be_installed matcher' do |valid_package|
  describe 'be_installed' do
    describe valid_package do
      it { should be_installed }
    end

    describe 'this-is-dummy-package' do
      it { should_not be_installed }
    end
  end
end

shared_examples_for 'support be_running matcher' do |valid_service|
  describe 'be_running' do
    describe valid_service do
      it { should be_running }
    end

    describe 'this-is-dummy-daemon' do
      it { should_not be_running }
    end
  end
end

shared_examples_for 'support be_listening matcher' do |valid_port|
  describe 'be_listening' do
    describe "port #{ valid_port }" do
      it { should be_listening }
    end

    describe 'port 9999' do
      it { should_not be_listening }
    end
  end
end

shared_examples_for 'support be_file matcher' do |valid_file|
  describe 'be_file' do
    describe valid_file do
      it { should be_file }
    end

    describe '/etc/thid_is_dummy_file' do
      it { should_not be_file }
    end
  end
end

shared_examples_for 'support contain matcher' do |valid_file, pattern|
  describe 'contain' do
    describe valid_file do
      it { should contain pattern }
    end

    describe '/etc/ssh/sshd_config' do
      it { should_not contain 'This is duymmy text!!' }
    end
  end
end
