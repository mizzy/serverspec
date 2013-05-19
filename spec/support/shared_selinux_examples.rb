shared_examples_for 'support selinux be_enforcing matcher' do
  describe selinux do
    it { should be_enforcing }
  end
end

shared_examples_for 'support selinux be_permissive matcher' do
  describe selinux do
    it { should be_permissive }
  end
end

shared_examples_for 'support selinux be_disabled matcher' do
  describe selinux do
    it { should be_disabled }
  end
end
