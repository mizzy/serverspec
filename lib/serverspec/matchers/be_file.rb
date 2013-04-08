RSpec::Matchers.define :be_file do
  match do |actual|
    backend.check_file(actual)
  end
end
