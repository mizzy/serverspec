module Serverspec
  module Type
    class SelinuxModule < Base
      def installed?(name, version)
        backend.check_selinux_module_installed(@name)
      end

      def enabled?
        backend.check_selinux_module_enabled(@name)
      end
    end
  end
end
