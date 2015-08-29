RSpec::Matchers.define :be_enforcing do
  match do |selinux|
    selinux.enforcing?(@with_policy)
  end

  chain :with_policy do |with_policy|
    @with_policy = with_policy
  end

end
