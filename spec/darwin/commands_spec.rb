require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec commands of Darwin family' do
  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'
  it_behaves_like 'support command check_process', 'httpd'
end
