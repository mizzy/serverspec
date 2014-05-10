module Serverspec
  module Type
    class Yumrepo < Base
      def exists?
        @runner.check_yumrepo(@name)
      end

      def enabled?
        @runner.check_yumrepo_enabled(@name)
      end
    end
  end
end
