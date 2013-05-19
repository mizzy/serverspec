RSpec::Matchers.define :be_reachable  do
  match do |host|
    proto   = 'tcp'
    timeout = 5
    if @attr
      port    = @attr[:port]
      proto   = @attr[:proto]   if @attr[:proto]
      timeout = @attr[:timeout] if @attr[:timeout]
    end

    if host.respond_to?(:reachable?)
      host.reachable?(port, proto, timeout)
    else
      backend.check_reachable(example, host, port, proto, timeout)
    end
  end

  chain :with do |attr|
    @attr = attr
  end
end

