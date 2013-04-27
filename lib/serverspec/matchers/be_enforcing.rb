RSpec::Matchers.define :be_enforcing do
  match do |actual|
    backend.check_selinux(example, 'enforcing')
  end
end
