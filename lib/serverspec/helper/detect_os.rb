module Serverspec
  module Helper
    module DetectOS
      def commands
        os = backend(Serverspec::Commands::Base).check_os
        self.class.const_get('Serverspec').const_get('Commands').const_get(os).new
      end
    end
  end
end
