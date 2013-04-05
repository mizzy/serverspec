module Serverspec
  module Helper
    module Ssh
      def backend
        Serverspec::Backend::Ssh.new(commands)
      end
    end
  end
end

