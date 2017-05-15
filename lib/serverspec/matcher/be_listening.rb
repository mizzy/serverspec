RSpec::Matchers.define :be_listening do
  match do |port|
    count = 0
    while ! (port.listening? @with, @local_address) && (count < @timeout) do
      count = count + 1
      puts "Port is not listening...#{@timeout-count}"
      sleep 1
    end
    port.listening? @with, @local_address
  end

  description do
    message = 'be listening'
    message << " on #{@local_address}" if @local_address
    message << " with #{@with}" if @with
    message
  end

  chain :with do |with|
    @with = with
  end

  chain :on do |local_address|
    @local_address = local_address
  end

  chain :timeout do |timeout|
    @timeout = timeout
  end
end
