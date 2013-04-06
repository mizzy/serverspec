RSpec::Matchers.define :be_enabled do
  match do |actual|
    backend.check_enabled(actual)
  end
end
