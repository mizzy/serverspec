module Serverspec
  module Type
    class Interface < Base
      def speed
        ret = backend.run_command(commands.get_interface_speed_of(@name))
        val = ret.stdout.strip
        val = val.to_i if val.match(/^\d+$/)
        val
      end

      def has_ipv4_address?(ip_address)
        backend.check_ipv4_address(@name, ip_address)
      end
      def has_ipv6_address?(ip_address)
        backend.check_ipv6_address(@name, ip_address)
      end
    end
  end
end
