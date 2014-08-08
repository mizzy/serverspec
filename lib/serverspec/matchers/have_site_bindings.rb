RSpec::Matchers.define :have_site_bindings do |port|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::IisWebsite'
      subject.has_site_bindings?(port, @protocol, @ipAddress, @hostHeader)
    else
      className = subject.class.name
      raise "not supported class #{className}"
    end
  end

  chain :with_protocol do |protocol|
    @protocol = protocol
  end

  chain :with_ipAddress do |ipAddress|
    @ipAddress = ipAddress
  end

  chain :with_hostHeader do |hostHeader|
    @hostHeader = hostHeader
  end
end
