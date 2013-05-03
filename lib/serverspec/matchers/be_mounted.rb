RSpec::Matchers.define :be_mounted do
  match do |path|
    backend.check_mounted(example, path)
  end
end
