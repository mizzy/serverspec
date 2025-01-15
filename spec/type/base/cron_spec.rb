require 'spec_helper'

set :os, :family => 'base'

describe cron do
  it { is_expected.to have_entry '* * * * * /usr/local/bin/batch.sh' }
end

describe cron do
  it { is_expected.to have_entry('* * * * * /usr/local/bin/batch.sh').with_user('root') }
end
