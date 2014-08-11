module Serverspec::Type
  class WindowsHotFix < Base
    def installed?(provider, version)
      @runner.check_hot_fix_is_installed(@name, version)
    end
  end
end
