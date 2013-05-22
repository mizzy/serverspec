shared_examples_for 'support command check_installed_by_gem' do |package|
  subject { commands.check_installed_by_gem(package) }
  it { should eq "gem list --local | grep -w -- ^#{package}" }
end

shared_examples_for 'support command check_installed_by_gem with_version' do |package, version|
  subject { commands.check_installed_by_gem(package) }
  it { should eq "gem list --local | grep -w -- ^#{package} | grep -w -- ^#{version}" }
end

shared_examples_for 'support command check_file' do |file|
  subject { commands.check_file(file) }
  it { should eq "test -f #{file}" }
end

shared_examples_for 'support command check_directory' do |dir|
  subject { commands.check_directory(dir) }
  it { should eq "test -d #{dir}" }
end

shared_examples_for 'support command check_mounted' do |path|
  subject { commands.check_mounted('/') }
  it { should eq "mount | grep -w -- on\\ #{path}" }
end

shared_examples_for 'support command check_routing_table' do |dest|
  subject { commands.check_routing_table(dest) }
  it { should eq "/sbin/ip route | grep -E '^#{dest} |^default '" }
end

shared_examples_for 'support command check_reachable' do
  context "connect with name from /etc/services to localhost" do
    subject { commands.check_reachable('localhost', 'ssh', 'tcp', 1) }
    it { should eq "nc -vvvvzt localhost ssh -w 1" }
  end
  context "connect with ip and port 11111 and timeout of 5" do
    subject { commands.check_reachable('127.0.0.1', '11111', 'udp', 5) }
    it { should eq "nc -vvvvzu 127.0.0.1 11111 -w 5" }
  end
  context "do a ping" do
    subject { commands.check_reachable('127.0.0.1', nil, 'icmp', 1) }
    it { should eq "ping -n 127.0.0.1 -w 1 -c 2" }
  end
end

shared_examples_for 'support command check_resolvable' do
  context "resolve localhost by hosts" do
    subject { commands.check_resolvable('localhost', 'hosts') }
    it { should eq "grep -w -- localhost /etc/hosts" }
  end
  context "resolve localhost by dns" do
    subject { commands.check_resolvable('localhost', 'dns') }
    it { should eq "nslookup -timeout=1 localhost" }
  end
  context "resolve localhost with default settings" do
    subject { commands.check_resolvable('localhost',nil) }
    it { should eq 'getent hosts localhost' }
  end
end

shared_examples_for 'support command check_user' do |user|
  subject { commands.check_user(user) }
  it { should eq "id #{user}" }
end

shared_examples_for 'support command check_group' do |group|
  subject { commands.check_group(group) }
  it { should eq "getent group | grep -wq -- #{group}" }
end

shared_examples_for 'support command check_listening' do |port|
  subject { commands.check_listening(port) }
  it { should eq "netstat -tunl | grep -- :#{port}\\ " }
end

shared_examples_for 'support command check_file_md5checksum' do |file, md5sum|
  subject { commands.check_file_md5checksum(file, md5sum) }
  it { should eq "md5sum #{file} | grep -iw -- ^#{md5sum}" }
end

shared_examples_for 'support command check_running_under_supervisor' do |service|
  subject { commands.check_running_under_supervisor(service) }
  it { should eq "supervisorctl status #{service}" }
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
