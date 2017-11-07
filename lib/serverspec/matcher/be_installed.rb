RSpec::Matchers.define :be_installed do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::SelinuxModule'
      subject.installed?(@version)
    else
      subject.installed?(@provider, @version)
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
