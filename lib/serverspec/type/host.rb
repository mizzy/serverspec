module Serverspec
  module Type
    class Host < Base
      def resolvable?(type)
        backend.check_resolvable(@name, type)
      end

      def reachable?(port, proto, timeout)
        backend.check_reachable(@name, port, proto, timeout)
      end

      def ipaddress
        backend.get_ipaddress_of_host(@name).stdout.strip
      end
    end
  end
end
