RSpec::Matchers.define :be_disabled do
  match do |actual|
    backend.check_disabled
  end
end
