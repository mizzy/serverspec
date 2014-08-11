module Serverspec::Type
  class Lxc < Base
    def exists?
      @runner.check_lxc_container_exists(@name)
    end

    def running?
      @runner.check_lxc_container_is_running(@name)
    end

    def to_s
      'LXC'
    end
  end
end
