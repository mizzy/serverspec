module Serverspec
  module Type
    class Group < Base
      def exists?
        @runner.check_group(@name)
      end

      def has_gid?(gid)
        @runner.check_gid(@name, gid)
      end
    end
  end
end
