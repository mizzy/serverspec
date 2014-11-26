module Serverspec::Type
  class Bridge < Base
    def exists?
      @runner.check_bridge_exists(@name)
    end

    def has_interface?(interface)
      @runner.check_bridge_has_interface(@name, interface)
    end
  end
end 
