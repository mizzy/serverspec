shared_examples_for 'support command check_installed_by_gem' do |package|
  describe 'check_installed_by_gem' do
    subject { commands.check_installed_by_gem(package) }
    it { should eq "gem list --local | grep -w -- ^#{package}" }
  end
end

shared_examples_for 'support command check_installed_by_gem with_version' do |package, version|
  describe 'check_installed_by_gem with_version' do |package, version|
    subject { commands.check_installed_by_gem(package) }
    it { should eq "gem list --local | grep -w -- ^#{package} | grep -w -- ^#{version}" }
  end
end
