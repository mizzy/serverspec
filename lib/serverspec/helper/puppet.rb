module Serverspec
  module Helper
    module Puppet
      def backend
        Serverspec::Backend::Puppet.new(commands)
      end
    end
  end
end
