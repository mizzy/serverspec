RSpec::Matchers.define :be_default_gateway do
  match do |ip_address|
    backend.check_routing_table(
      {
        :destination => 'default',
        :gateway     => ip_address,
        :interface   => @interface
      }
    )
  end
  chain :with_interface do |interface|
    @interface = interface
  end
end
