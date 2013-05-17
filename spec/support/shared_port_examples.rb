shared_examples_for 'support port listening matcher' do |num|
  describe 'listening' do
    describe port(num) do
      it { should be_listening }
    end

    describe port('invalid') do
      it { should_not be_listening }
    end
  end
end
