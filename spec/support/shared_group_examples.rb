include Serverspec::Helper::Exec

shared_examples_for 'support user exist matcher' do |name|
  describe 'user exist' do
    describe user(name) do
      it { should exist }
    end

    describe user('invalid-user') do
      it { should_not exist }
    end
  end
end

shared_examples_for 'support user belong_to_group matcher' do |name, group|
  describe 'belong_to_group' do
    describe user(name) do
      it { should belong_to_group group }
    end

    describe user(name) do
      it { should_not belong_to_group 'invalid-group' }
    end
  end
end

shared_examples_for 'support user have_uid matcher' do |name, uid|
  describe 'have_uid' do
    describe user(name) do
      it { should have_uid uid }
    end

    describe user(name) do
      it { should_not have_uid 'invalid-uid' }
    end
  end
end

shared_examples_for 'support user have_login_shell matcher' do |name, path_to_shell|
  describe 'have_login_shell' do
    describe user(name) do
      it { should have_login_shell path_to_shell }
    end

    describe user(name) do
      it { should_not have_login_shell 'invalid-login-shell' }
    end
  end
end

shared_examples_for 'support user have_home_directory matcher' do |name, path_to_home|
  describe 'have_home_directory' do
    describe user(name) do
      it { should have_home_directory path_to_home }
    end

    describe user(name) do
      it { should_not have_home_directory 'invalid-home-directory' }
    end
  end
end

shared_examples_for 'support user have_authorized_key matcher' do |name, key|
  describe 'have_authorized_key' do
    describe user(name) do
      it { should have_authorized_key key }
    end

    describe user(name) do
      it { should_not have_authorized_key 'invalid-publickey' }
    end
  end
end
