RSpec::Matchers.define :be_selinux do
  match do |mode|
    backend.check_selinux(example,mode)
  end
end
