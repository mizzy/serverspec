RSpec::Matchers.define :be_permissive do
  match do |selinux|
    selinux.permissive?(@with_policy)
  end

  chain :with_policy do |with_policy|
    @with_policy = with_policy
  end

end
