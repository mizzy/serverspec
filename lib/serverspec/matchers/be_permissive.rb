RSpec::Matchers.define :be_permissive do
  match do |actual|
    if subject.respond_to?(:permissive?)
      subject.permissive?
    else
      backend.check_selinux('permissive')
    end
  end
end
