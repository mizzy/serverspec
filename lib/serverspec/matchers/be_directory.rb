RSpec::Matchers.define :be_directory do
  match do |actual|
    backend.check_directory(actual)
  end
end
