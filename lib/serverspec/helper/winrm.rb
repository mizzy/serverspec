module Serverspec
  module Helper
    module WinRM
      def backend(commands_object=nil)
        if ! respond_to?(:commands)
          commands_object = Serverspec::Commands::Windows.new
        end
        instance = Serverspec::Backend::WinRM.instance
        instance.set_commands(commands_object || commands)
        instance
      end
    end
  end
end

