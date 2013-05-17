shared_examples_for 'support service enabled matcher' do |valid_service|
  describe 'be_enabled' do
    describe service(valid_service) do
      it { should be_enabled }
    end

    describe service('invalid-service') do
      it { should_not be_enabled }
    end
  end
end

shared_examples_for 'support service running matcher' do |valid_service|
  describe 'be_running' do
    describe service(valid_service) do
      it { should be_running }
    end

    describe service('invalid-daemon') do
      it { should_not be_running }
    end

    describe service(valid_service) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} is stopped\r\n"
        end
      end
      it { should be_running }
    end
  end
end

shared_examples_for 'support service running under supervisor matcher' do |valid_service|
  describe 'be_running.under("supervisor")' do
    describe service(valid_service) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} RUNNING\r\n"
        end
      end

      it { should be_running.under('supervisor') }
    end

    describe service(valid_service) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{valid_service} STOPPED\r\n"
        end
      end

      it { should_not be_running.under('supervisor') }
    end

    describe service('invalid-daemon') do
      it { should_not be_running.under('supervisor') }
    end
  end
end

shared_examples_for 'support service running under unimplemented matcher' do |valid_service|
  describe 'be_running.under("not implemented")' do
    describe service(valid_service) do
      it {
        expect {
          should be_running.under('not implemented')
        }.to raise_error(ArgumentError, %r/\A`be_running` matcher doesn\'t support/)
      }
    end
  end
end
