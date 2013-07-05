shared_examples_for 'support command check_running_under_supervisor' do |service|
  subject { commands.check_running_under_supervisor(service) }
  it { should eq "supervisorctl status #{service}" }
end

shared_examples_for 'support command check_running_under_upstart' do |service|
  subject { commands.check_running_under_upstart(service) }
  it { should eq "initctl status #{service}" }
end

shared_examples_for 'support command check_monitored_by_monit' do |service|
  subject { commands.check_monitored_by_monit(service) }
  it { should eq "monit status" }
end

shared_examples_for 'support command check_process' do |process|
  subject { commands.check_process(process) }
  it { should eq "ps aux | grep -w -- #{process} | grep -qv grep" }
end
