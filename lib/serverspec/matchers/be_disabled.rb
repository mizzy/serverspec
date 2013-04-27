RSpec::Matchers.define :be_disabled do
  match do |actual|
    backend.check_selinux(example, 'disabled')
  end
end
