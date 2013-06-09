module Serverspec
  module Type
    class Group < Base
      def exists?
        backend.check_group(@name)
      end

      def has_gid?(gid)
        backend.check_gid(@name, gid)
      end
    end
  end
end
