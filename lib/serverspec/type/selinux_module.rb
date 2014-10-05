module Serverspec::Type
  class SelinuxModule < Base
    def enabled?
      @runner.check_selinux_module_is_enabled(@name)
    end

    def installed?(name, version=nil)
      @runner.check_selinux_module_is_installed(@name, version)
    end
  end
end
