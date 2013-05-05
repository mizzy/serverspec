RSpec::Matchers.define :be_reachable  do
  match do |socket|
    
    socket = socket.split(":")
    
    ip = socket[0]
    port = socket[1]
    proto = port ? "tcp" : "icmp"
    timeout = 5;

    if @attr =~ /^(tcp|udp|icmp)$/
      proto = $1    
    elsif @attr.is_a? Hash
      proto = @attr[:proto] || proto
      timeout = @attr[:timeout] || timeout
      ip = @attr[:ip] || ip
      port = @attr[:port] || port
    end

    backend.check_reachable(example, ip, port, proto, timeout)
  end
  chain :with do |attr|
    @attr = attr
  end
end
