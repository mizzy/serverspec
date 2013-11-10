module Serverspec
  module Helper
    module Cmd
      def backend(commands_object=nil)
        if ! respond_to?(:commands)
          commands_object = Serverspec::Commands::Windows.new
        end
        instance = Serverspec::Backend::Cmd.instance
        instance.set_commands(commands_object || commands)
        instance
      end
    end
  end
end

