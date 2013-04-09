RSpec::Matchers.define :be_directory do
  match do |actual|
    backend.check_directory(example, actual)
  end
end
