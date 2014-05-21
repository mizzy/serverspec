module Serverspec
  module Type
    class Ppa < Base
      def exists?
        backend.check_ppa(@name)
      end

      def enabled?
        backend.check_ppa_enabled(@name)
      end
    end
  end
end
