module Serverspec::Type
  class Host < Base
    def resolvable?(type)
      @runner.check_host_is_resolvable(@name, type)
    end

    def reachable?(port, proto, timeout)
      @runner.check_host_is_reachable(@name, port, proto, timeout)
    end

    def ipaddress
      @runner.get_host_ipaddress(@name).stdout.strip
    end
    def ipv4_address
      @runner.get_host_ipv4_address(@name).stdout.strip
    end
    def ipv6_address
      @runner.get_host_ipv6_address(@name).stdout.strip
    end
  end
end
