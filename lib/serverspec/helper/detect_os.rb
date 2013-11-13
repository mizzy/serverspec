module Serverspec
  module Helper
    module DetectOS
      def commands
        property[:os_type] = {} if ! property[:os_type]
        host = RSpec.configuration.ssh ? RSpec.configuration.ssh.host : 'localhost'

        if property[:os_type][host]
          os = property[:os_type][host]
        else
          os = backend(Serverspec::Commands::Base).check_os
          property[:os_type][host] = os
        end

        self.class.const_get('Serverspec').const_get('Commands').const_get(os).new
      end
    end
  end
end
