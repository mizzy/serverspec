module Serverspec
  module Helper
    module Ssh
      def backend(commands_object=nil)
        Serverspec::Backend::Ssh.new(commands_object || commands)
      end
    end
  end
end

