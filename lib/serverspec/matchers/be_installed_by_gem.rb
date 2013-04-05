RSpec::Matchers.define :be_installed_by_gem do
  match do |name|
    backend.check_installed_by_gem(name, @version)
  end
  chain :with_version do |version|
    @version = version
  end
end
