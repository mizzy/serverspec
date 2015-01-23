RSpec::Matchers.define :be_auto_mounted do
  match do |path|
    path.auto_mounted?(@attr, @only_with)
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
