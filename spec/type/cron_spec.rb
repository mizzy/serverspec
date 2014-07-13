require 'spec_helper'

set :os, :family => 'redhat'

describe cron do
  it { should have_entry '* * * * * /usr/local/bin/batch.sh' }
end

describe cron do
  it { should_not have_entry 'invalid entry' }
end

describe cron do
  it { should have_entry('* * * * * /usr/local/bin/batch.sh').with_user('root') }
end

describe cron do
  it { should_not have_entry('* * * * * /usr/local/bin/batch.sh').with_user('invalid-user') }
end
