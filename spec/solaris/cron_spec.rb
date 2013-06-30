require 'spec_helper'

include Serverspec::Helper::Solaris

describe cron do
  it { should have_entry '* * * * * /usr/local/bin/batch.sh' }
  its(:command) { should eq 'crontab -l | grep -- \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ /usr/local/bin/batch.sh' }
end

describe cron do
  it { should_not have_entry 'invalid entry' }
end

describe cron do
  it { should have_entry('* * * * * /usr/local/bin/batch.sh').with_user('root') }
  its(:command) { should eq 'crontab -l root | grep -- \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ \\\\\\*\\ /usr/local/bin/batch.sh' }
end

describe cron do
  it { should_not have_entry('* * * * * /usr/local/bin/batch.sh').with_user('invalid-user') }
end
