module Serverspec
  module Helper
    module Ssh
      def backend(commands_object=nil)
        if ! respond_to?(:commands)
          commands_object = Serverspec::Commands::Base.new
        end
        instance = Serverspec::Backend::Ssh.instance
        instance.set_commands(commands_object || commands)
        instance
      end
    end
  end
end

