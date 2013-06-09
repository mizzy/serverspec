RSpec::Matchers.define :be_mounted do
  match do |path|
    if path.respond_to?(:mounted?)
      path.mounted?(@attr, @only_with)
    else
      backend.check_mounted(path, @attr, @only_with)
    end
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
