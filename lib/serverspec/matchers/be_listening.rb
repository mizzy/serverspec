RSpec::Matchers.define :be_listening do
  match do |port|
    port.listening? @with, @local_address
  end

  chain :with do |with|
    @with = with
  end

  chain :on do |local_address|
    @local_address = local_address
  end
end
