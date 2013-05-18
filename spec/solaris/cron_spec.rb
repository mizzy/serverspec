require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec cron matchers of Solaris family' do
  it_behaves_like 'support cron have_entry matcher', '* * * * * /usr/local/bin/batch.sh'
  it_behaves_like 'support cron have_entry with user matcher', '* * * * * /usr/local/bin/batch.sh', 'root'
end
