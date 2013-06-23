module Serverspec
  module Type
    class Repository < Base
      def exists?
        backend.check_repos(@name)
      end

      def enabled?
        backend.check_repos_enabled(@name)
      end
    end
  end
end
