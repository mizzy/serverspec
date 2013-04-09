RSpec::Matchers.define :be_file do
  match do |actual|
    backend.check_file(example, actual)
  end
end
