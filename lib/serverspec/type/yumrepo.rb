module Serverspec
  module Type
    class Yumrepo < Base
      def exists?
        backend.check_yumrepo(@name)
      end

      def enabled?
        backend.check_yumrepo_enabled(@name)
      end
    end
  end
end
