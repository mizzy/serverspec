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
