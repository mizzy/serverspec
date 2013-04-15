module Serverspec
  module Helper
    module Exec
      def backend(commands_object=nil)
        Serverspec::Backend::Exec.new(commands_object || commands)
      end
    end
  end
end
