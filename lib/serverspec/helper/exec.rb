module Serverspec
  module Helper
    module Exec
      def backend(commands_object=nil)
        instance = Serverspec::Backend::Exec.instance
        instance.set_commands(commands_object || commands)
        instance
      end
    end
  end
end
