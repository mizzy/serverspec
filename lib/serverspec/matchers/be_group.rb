RSpec::Matchers.define :be_group do
  match do |actual|
    backend.check_group(actual)
  end
end
