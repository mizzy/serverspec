module Serverspec
  module Type
    class Group < Base
      def exists?
        backend.check_group(nil, @name)
      end

      def has_gid?(gid)
        backend.check_gid(nil, @name, gid)
      end
    end
  end
end
