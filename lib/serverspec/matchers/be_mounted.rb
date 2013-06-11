RSpec::Matchers.define :be_mounted do
  match do |path|
    path.mounted?(@attr, @only_with)
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
