module Serverspec
  module Type
    class Ppa < Base
      def exists?
        backend.check_ppa_exists(@name)
      end

      def enabled?
        backend.check_ppa_is_enabled(@name)
      end
    end
  end
end
