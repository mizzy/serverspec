module Serverspec
  module Type
    class KernelModule < Base
      def loaded?
        backend.check_kmod_loaded(@name)
      end
    end
  end
end
