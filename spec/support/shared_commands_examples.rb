shared_examples_for 'support command check_user' do |user|
  subject { commands.check_user(user) }
  it { should eq "id #{user}" }
end

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

shared_examples_for 'support command check_belonging_group' do |user, group|
  subject { commands.check_belonging_group(user, group) }
  it { should eq "id #{user} | awk '{print $3}' | grep -- #{group}" }
end

shared_examples_for 'support command check_uid' do |user, uid|
  subject { commands.check_uid('root', 0) }
  it { should eq "id #{user} | grep -- \\^uid\\=#{uid}\\(" }
end

shared_examples_for 'support command check_login_shell' do |user, shell|
  subject { commands.check_login_shell(user, shell) }
  it { should eq "getent passwd #{user} | cut -f 7 -d ':' | grep -w -- #{shell}" }
end

shared_examples_for 'support command check_home_directory' do |user, home|
  subject { commands.check_home_directory(user, home) }
  it { should eq "getent passwd #{user} | cut -f 6 -d ':' | grep -w -- #{home}" }
end

shared_examples_for 'support command check_authorized_key' do
  key = "ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH"
  escaped_key = key.gsub(/ /, '\ ')

  context 'with commented publickey' do
    commented_key = key + " foo@bar.local"
    subject { commands.check_authorized_key('root', commented_key) }
    describe 'when command insert publickey is removed comment' do
      it { should eq "grep -w -- #{escaped_key} ~root/.ssh/authorized_keys" }
    end
  end

  context 'with uncomented publickey' do
    subject { commands.check_authorized_key('root', key) }
    it { should eq "grep -w -- #{escaped_key} ~root/.ssh/authorized_keys" }
  end
end
