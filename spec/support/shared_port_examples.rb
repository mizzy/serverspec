shared_examples_for 'support port listening matcher' do |valid_port|
  describe 'be_running' do
    describe port(valid_port) do
      it { should be_listening }
    end

    describe port('invalid-port') do
      it { should_not be_listening }
    end
  end
end

shared_examples_for 'support port with protocol matcher' do |valid_port, protocol|
  describe 'be_running' do
    describe port(valid_port) do
      it { should be_listening.with(protocol) }
    end

    describe port('invalid-port') do
      it { should_not be_listening.with(protocol) }
    end
  end
end
