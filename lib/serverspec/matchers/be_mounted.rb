RSpec::Matchers.define :be_mounted do
  match do |path|
    backend.check_mounted(example, path, @attr, @only_with)
  end
  chain :with do |attr|
    @attr      = attr
    @only_with = false
  end
  chain :only_with do |attr|
    @attr      = attr
    @only_with = true
  end
end
