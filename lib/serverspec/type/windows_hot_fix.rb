module Serverspec
  module Type
    class WindowsHotFix < Base
      def installed?(provider, version)
        backend.check_windows_hot_fix_installed(@name, version)
      end
    end
  end
end
