RSpec::Matchers.define :be_disabled do
  match do |subject|
    if subject.respond_to?(:disabled?)
      subject.disabled?
    else
      backend.check_selinux(example, 'disabled')
    end
  end
end
