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
