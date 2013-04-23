RSpec::Matchers.define :be_enforcing do
  match do |actual|
    # backend.check_enforcing(example,actual)
    backend.check_enforcing
  end
end
