module Serverspec::Type
  class KernelModule < Base
    def loaded?
      @runner.check_kernel_module_is_loaded(@name)
    end
  end
end
