shared_examples_for 'support command check_file' do |file|
  subject { commands.check_file(file) }
  it { should eq "test -f #{file}" }
end

shared_examples_for 'support command check_directory' do |dir|
  subject { commands.check_directory(dir) }
  it { should eq "test -d #{dir}" }
end

shared_examples_for 'support command check_socket' do |socket|
  subject { commands.check_socket(socket) }
  it { should eq "test -S #{socket}" }
end

shared_examples_for 'support command check_mounted' do |path|
  subject { commands.check_mounted('/') }
  it { should eq "mount | grep -w -- on\\ #{path}" }
end

shared_examples_for 'support command check_user' do |user|
  subject { commands.check_user(user) }
  it { should eq "id #{user}" }
end

shared_examples_for 'support command check_group' do |group|
  subject { commands.check_group(group) }
  it { should eq "getent group | grep -wq -- #{group}" }
end

shared_examples_for 'support command check_file_md5checksum' do |file, md5sum|
  subject { commands.check_file_md5checksum(file, md5sum) }
  it { should eq "md5sum #{file} | grep -iw -- ^#{md5sum}" }
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

shared_examples_for 'support command check_file_contain' do |file, content|
  subject { commands.check_file_contain(file, content) }
  it { should eq "grep -q -- #{content} #{file}" }
end

shared_examples_for 'support command check_file_contain_within' do
  context 'contain a pattern in the file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec') }
    it { should eq "sed -n 1,\\$p Gemfile | grep -q -- rspec -" }
  end

  context 'contain a pattern after a line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/') }
    it { should eq "sed -n /\\^group\\ :test\\ do/,\\$p Gemfile | grep -q -- rspec -" }
  end

  context 'contain a pattern before a line in a file' do
    subject {commands.check_file_contain_within('Gemfile', 'rspec', nil, '/^end/') }
    it { should eq "sed -n 1,/\\^end/p Gemfile | grep -q -- rspec -" }
  end

  context 'contain a pattern from within a line and another line in a file' do
    subject { commands.check_file_contain_within('Gemfile', 'rspec', '/^group :test do/', '/^end/') }
    it { should eq "sed -n /\\^group\\ :test\\ do/,/\\^end/p Gemfile | grep -q -- rspec -" }
  end
end

shared_examples_for 'support command check_mode' do |file, mode|
  subject { commands.check_mode(file, mode) }
  it { should eq "stat -c %a #{file} | grep -- \\^#{mode}\\$" }
end

shared_examples_for 'support command check_owner' do |file, owner|
  subject { commands.check_owner(file, owner) }
  it { should eq "stat -c %U #{file} | grep -- \\^#{owner}\\$" }
end

shared_examples_for 'support command check_grouped' do |file, group|
  subject { commands.check_grouped(file, group) }
  it { should eq "stat -c %G #{file} | grep -- \\^#{group}\\$" }
end

shared_examples_for 'support command check_link' do |link, target|
  subject { commands.check_link(link, target) }
  it { should eq "stat -c %N #{link} | grep -- #{target}" }
end

shared_examples_for 'support command check_belonging_group' do |user, group|
  subject { commands.check_belonging_group(user, group) }
  it { should eq "id #{user} | awk '{print $3}' | grep -- #{group}" }
end

shared_examples_for 'support command check_uid' do |user, uid|
  subject { commands.check_uid('root', 0) }
  it { should eq "id #{user} | grep -- \\^uid\\=#{uid}\\(" }
end

shared_examples_for 'support command check_gid' do |group, gid|
  subject { commands.check_gid('root', 0) }
  it { should eq "getent group | grep -w -- \\^#{group} | cut -f 3 -d ':' | grep -w -- #{gid}" }
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

shared_examples_for 'support command check_selinux' do
  context 'enforcing' do
    subject { commands.check_selinux('enforcing') }
    it { should eq "getenforce | grep -i -- enforcing && grep -i -- ^SELINUX=enforcing$ /etc/selinux/config" }
  end

  context 'permissive' do
    subject { commands.check_selinux('permissive') }
    it { should eq "getenforce | grep -i -- permissive && grep -i -- ^SELINUX=permissive$ /etc/selinux/config" }
  end

  context 'disabled' do
    subject { commands.check_selinux('disabled') }
    it { should eq "getenforce | grep -i -- disabled && grep -i -- ^SELINUX=disabled$ /etc/selinux/config" }
  end
end

shared_examples_for 'support command get_mode' do
  subject { commands.get_mode('/dev') }
  it { should eq 'stat -c %a /dev' }
end

shared_examples_for 'support command check_access_by_user' do
  context 'read access' do
    subject {commands.check_access_by_user '/tmp/something', 'dummyuser1', 'r'}
    it { should eq  'su -c "test -r /tmp/something" dummyuser1' }
  end

  context 'write access' do
    subject {commands.check_access_by_user '/tmp/somethingw', 'dummyuser2', 'w'}
    it { should eq  'su -c "test -w /tmp/somethingw" dummyuser2' }
  end

  context 'execute access' do
    subject {commands.check_access_by_user '/tmp/somethingx', 'dummyuser3', 'x'}
    it { should eq  'su -c "test -x /tmp/somethingx" dummyuser3' }
  end
end

shared_examples_for 'support command check_kernel_module_loaded' do |name|
  subject { commands.check_kernel_module_loaded(name) }
  it { should eq "lsmod | grep ^#{name}" }
end
