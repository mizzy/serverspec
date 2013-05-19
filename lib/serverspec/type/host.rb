module Serverspec
  module Type
    class Host < Base
      def resolvable?(type)
        backend.check_resolvable(nil, @name, type)
      end

      def reachable?(port, proto, timeout)
        backend.check_reachable(nil, @name, port, proto, timeout)
      end
    end
  end
end
