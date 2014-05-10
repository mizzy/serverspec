module Serverspec
  module Type
    class Lxc < Base
      def exists?
        @runner.check_container(@name)
      end

      def running?
        @runner.check_container_running(@name)
      end

      def to_s
        'LXC'
      end
    end
  end
end
