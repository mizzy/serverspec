module Serverspec
  module Helper
    module SetBackendByConfig
      def backend(commands_object=nil)
        if ! respond_to?(:commands)
          commands_object = Serverspec::Commands::Base.new
        end
        be = RSpec.configuration.backend
        instance = self.class.const_get('Serverspec').const_get('Backend').const_get(be).instance
        instance.set_commands(commands_object || commands)
        instance
      end
    end
  end
end
