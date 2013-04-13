module Serverspec
  module Helper
    module Exec
      def backend(commmands_object=nil)
        Serverspec::Backend::Exec.new(commands_object || commands)
      end
    end
  end
end
