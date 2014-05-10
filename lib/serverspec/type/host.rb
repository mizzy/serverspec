module Serverspec
  module Type
    class Host < Base
      def resolvable?(type)
        @runner.check_resolvable(@name, type)
      end

      def reachable?(port, proto, timeout)
        @runner.check_reachable(@name, port, proto, timeout)
      end

      def ipaddress
        @runner.get_ipaddress_of_host(@name).stdout.strip
      end
    end
  end
end
