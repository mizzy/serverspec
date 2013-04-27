RSpec::Matchers.define :be_permissive do
  match do |actual|
    backend.check_selinux(example, 'permissive')
  end
end
