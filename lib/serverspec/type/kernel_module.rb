module Serverspec
  module Type
    class KernelModule < Base
      def loaded?
        @runner.check_kernel_module_loaded(@name)
      end
    end
  end
end
