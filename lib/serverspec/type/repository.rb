module Serverspec
  module Type
    class Repository < Base
      def exists?
        backend.check_repository(@name)
      end

      def enabled?
        backend.check_repository_enabled(@name)
      end
    end
  end
end
