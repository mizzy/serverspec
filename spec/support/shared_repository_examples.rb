shared_examples_for 'support repository exist matcher' do |valid_repository|
  describe 'exist' do
    describe repository(valid_repository) do
      it { should exist }
    end

    describe repository('invalid-repository') do
      it { should_not exist }
    end
  end
end

shared_examples_for 'support repository be_enabled matcher' do |valid_repository|
  describe 'be_enabled' do
    describe repository(valid_repository) do
      it { should be_enabled }
    end

    describe repository('invalid-repository') do
      it { should_not be_enabled }
    end
  end
end
