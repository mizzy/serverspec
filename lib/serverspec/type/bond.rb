module Serverspec::Type
  class Bond < Base
    def exists?
      @runner.check_bond_exists(@name)
    end

    def has_interface?(interface)
      @runner.check_bond_has_interface(@name, interface)
    end
  end
end
