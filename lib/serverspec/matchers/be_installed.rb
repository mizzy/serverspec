RSpec::Matchers.define :be_installed do
  match do |name|
    name.installed?(@provider, @version)
  end

  chain :by do |provider|
    @provider = provider
  end

  chain :with_version do |version|
    @version = version
  end

end
