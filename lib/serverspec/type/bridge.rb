module Serverspec::Type
  class Bridge < Base
    def exists?
      @runner.check_bridge_exists(@name)
    end

    def has_interface?(intf)
      @runner.check_bridge_has_interface(@name, intf)
    end
  end
end 
