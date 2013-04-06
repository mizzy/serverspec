module Serverspec
  module Helper
    module Exec
      def backend
        Serverspec::Backend::Exec.new(commands)
      end
    end
  end
end
