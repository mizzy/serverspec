RSpec::Matchers.define :be_enforcing do
  match do |actual|
    if subject.respond_to?(:enforcing?)
      subject.enforcing?
    else
      backend.check_selinux(example, 'enforcing')
    end
  end
end

