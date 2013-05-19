require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec cron matchers of Red Hat family' do
  it_behaves_like 'support cron have_entry matcher', '* * * * * /usr/local/bin/batch.sh'
  it_behaves_like 'support cron have_entry with user matcher', '* * * * * /usr/local/bin/batch.sh', 'root'
end
