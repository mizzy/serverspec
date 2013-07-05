require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec commands of Gentoo family' do
  it_behaves_like 'support command check_running_under_supervisor', 'httpd'
  it_behaves_like 'support command check_monitored_by_monit', 'unicorn'
  it_behaves_like 'support command check_process', 'httpd'
end

describe 'check_enabled' do
  subject { commands.check_enabled('httpd') }
  it { should eq "rc-update show | grep -- \\^\\\\s\\*httpd\\\\s\\*\\|\\\\s\\*\\\\\\(boot\\\\\\|default\\\\\\)" }
end

describe 'check_running' do
  subject { commands.check_running('httpd') }
  it { should eq '/etc/init.d/httpd status' }
end

