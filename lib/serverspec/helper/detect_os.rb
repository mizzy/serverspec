module Serverspec
  module Helper
    module DetectOS
      def commands
        attr[:os_type] = {} if ! attr[:os_type]
        host = RSpec.configuration.ssh ? RSpec.configuration.ssh.host : 'localhost'

        if attr[:os_type][host]
          os = attr[:os_type][host]
        else
          os = backend(Serverspec::Commands::Base).check_os
          attr[:os_type][host] = os
        end

        self.class.const_get('Serverspec').const_get('Commands').const_get(os).new
      end
    end
  end
end
