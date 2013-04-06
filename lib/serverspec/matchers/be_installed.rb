RSpec::Matchers.define :be_installed do
  match do |actual|
    backend.check_installed(actual)
  end
end
