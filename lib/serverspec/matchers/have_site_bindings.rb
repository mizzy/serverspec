RSpec::Matchers.define :have_site_bindings do |port|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::IisWebsite'
      subject.has_site_bindings?(port, @protocol, @ipaddress, @host_header)
    else
      className = subject.class.name
      raise "not supported class #{className}"
    end
  end

  chain :with_protocol do |protocol|
    @protocol = protocol
  end

  chain :with_ipaddress do |ipaddress|
    @ipaddress = ipaddress
  end

  chain :with_host_header do |host_header|
    @host_header = host_header
  end
end
