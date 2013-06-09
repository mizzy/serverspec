RSpec::Matchers.define :be_user do
  match do |actual|
    backend.check_user(actual)
  end
end
