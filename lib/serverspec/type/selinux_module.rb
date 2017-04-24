module Serverspec::Type
  class SelinuxModule < Base
    def enabled?
      @runner.check_selinux_module_is_enabled(@name)
    end

    def installed?(version = nil)
      @runner.check_selinux_module_is_installed(@name, version)
    end

    def to_s
      %(SELinux module "#{@name}")
    end
  end
end
