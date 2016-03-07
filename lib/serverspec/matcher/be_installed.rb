RSpec::Matchers.define :be_installed do
  match do |name|
    if subject.class.name == 'Serverspec::Type::SelinuxModule'
      name.installed?(@version)
    else
      name.installed?(@provider, @version)
    end
  end

  description do
    message = 'be installed'
    message << %( by "#{@provider}") if @provider
    message << %( with version "#{@version}") if @version
    message
  end

  chain :by do |provider|
    @provider = provider
  end

  chain :with_version do |version|
    @version = version
  end
end
