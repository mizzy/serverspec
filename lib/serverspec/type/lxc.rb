module Serverspec
  module Type
    class Lxc < Base
      def exists?
        backend.check_container(@name)
      end

      def running?(under)
        backend.check_container_running(@name)
      end

      def to_s
        'LXC'
      end
    end
  end
end
