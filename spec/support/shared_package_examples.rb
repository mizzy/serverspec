shared_examples_for 'support package installed matcher' do |name|
  describe 'be_installed' do
    describe package(name) do
      it { should be_installed }
    end

    describe 'invalid-package' do
      it { should_not be_installed }
    end
  end
end

shared_examples_for 'support package installed by gem matcher' do |name|
  describe 'installed by gem' do
    describe package(name) do
      it { should be_installed.by('gem') }
    end

    describe 'invalid-gem' do
      it { should_not be_installed.by('gem') }
    end
  end
end

shared_examples_for 'support package installed by gem with version matcher' do |name, version|
  describe 'installed by gem with version' do
    describe package(name) do
      it { should be_installed.by('gem').with_version(version) }
    end

    describe package(name) do
      it { should_not be_installed.by('gem').with_version('invalid-version') }
    end
  end
end

shared_examples_for 'support package installed by npm matcher' do |name|
  describe 'installed by npm' do
    describe package(name) do
      it { should be_installed.by('npm') }
    end

    describe 'invalid-npm' do
      it { should_not be_installed.by('npm') }
    end
  end
end

shared_examples_for 'support package installed by npm with version matcher' do |name, version|
  describe 'installed by npm with version' do
    describe package(name) do
      it { should be_installed.by('npm').with_version(version) }
    end

    describe package(name) do
      it { should_not be_installed.by('npm').with_version('invalid-version') }
    end
  end
end
