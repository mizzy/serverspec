RSpec::Matchers.define :be_mounted do
  match do |actual|
    backend.check_mounted(example, actual)
  end
end
