module Serverspec::Type
  class LibvirtLxc < Base
    def exists?
      @runner.check_libvirt_lxc_container_exists(@name)
    end

    def running?
      @runner.check_libvirt_lxc_container_is_running(@name)
    end

    def to_s
      'LibvirtLXC'
    end
  end
end
