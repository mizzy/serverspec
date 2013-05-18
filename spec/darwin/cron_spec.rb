require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec cron matchers of Darwin family' do
  it_behaves_like 'support cron have_entry matcher', '* * * * * /usr/local/bin/batch.sh'
  it_behaves_like 'support cron have_entry with user matcher', '* * * * * /usr/local/bin/batch.sh', 'root'
end
