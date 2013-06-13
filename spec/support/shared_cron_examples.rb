shared_examples_for 'support cron have_entry matcher' do |entry|
  describe 'have_cron_entry' do
    describe cron do
      it { should have_entry entry }
    end

    describe cron do
      it { should_not have_entry 'invalid entry' }
    end
  end
end

shared_examples_for 'support cron have_entry with user matcher' do |entry, user|
  describe 'have_cron_entry' do
    describe cron do
      it { should have_entry(entry).with_user(user) }
    end

    describe cron do
      it { should_not have_entry('invalid entry').with_user(user) }
    end
  end
end
