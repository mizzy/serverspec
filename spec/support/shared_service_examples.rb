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

shared_examples_for 'support service enabled with level matcher' do |valid_service, level|
  describe 'be_enabled' do
    describe service(valid_service) do
      it { should be_enabled.with_level(level) }
    end

    describe service('invalid-service') do
      it { should_not be_enabled.with_level(level) }
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
      let(:stdout) { "#{valid_service} is stopped\r\n" }
      it { should be_running }
    end
  end
end

shared_examples_for 'support service running under supervisor matcher' do |valid_service|
  describe 'be_running.under("supervisor")' do
    describe service(valid_service) do
      let(:stdout) { "#{valid_service} RUNNING\r\n" }
      it { should be_running.under('supervisor') }
    end

    describe service(valid_service) do
      let(:stdout) { "#{valid_service} STOPPED\r\n" }
      it { should_not be_running.under('supervisor') }
    end

    describe service('invalid-daemon') do
      it { should_not be_running.under('supervisor') }
    end
  end
end

shared_examples_for 'support service running under upstart matcher' do |valid_service|
  describe 'be_running.under("upstart")' do
    describe service(valid_service) do
      let(:stdout) { "#{valid_service} running\r\n" }
      it { should be_running.under('upstart') }
    end

    describe service(valid_service) do
      let(:stdout) { "#{valid_service} waiting\r\n" }
      it { should_not be_running.under('upstart') }
    end

    describe service('invalid-daemon') do
      it { should_not be_running.under('upstart') }
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

shared_examples_for 'support service monitored by monit matcher' do |valid_service|
  describe 'be_monitored_by("monit")' do
    describe service(valid_service) do
      let(:stdout) { "Process '#{valid_service}'\r\n  status running\r\n  monitoring status  monitored" }
      it { should be_monitored_by('monit') }
    end

    describe service(valid_service) do
      let(:stdout) { "Process '#{valid_service}'\r\n  status  not monitored\r\n  monitoring status  not monitored" }
      it { should_not be_monitored_by('monit') }
    end

    describe service('invalid-daemon') do
      it { should_not be_monitored_by('monit') }
    end
  end
end

shared_examples_for 'support service monitored by unimplemented matcher' do |valid_service|
  describe 'be_monitored_by("not implemented")' do
    describe service(valid_service) do
      it {
        expect {
          should be_monitored_by('not implemented')
        }.to raise_error(ArgumentError, %r/\A`be_monitored_by` matcher doesn\'t support/)
      }
    end
  end
end
