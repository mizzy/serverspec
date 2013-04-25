RSpec::Matchers.define :be_permissive do
  match do |actual|
    backend.check_permissive
  end
end
