RSpec::Matchers.define :be_reachable  do
  match do |host|
    proto   = 'tcp'
    timeout = 5
    if @attr
      port    = @attr[:port]
      proto   = @attr[:proto]   if @attr[:proto]
      timeout = @attr[:timeout] if @attr[:timeout]
    end

    backend.check_reachable(example, host, port, proto, timeout)
  end

  chain :with do |attr|
    @attr = attr
  end

  failure_message_for_should do |host|
    message =  "#{example.metadata[:command]}\n"
    message += "#{example.metadata[:stdout]}"
    message
  end
end
