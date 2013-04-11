module Serverspec
  module Helper
    module OSDetect
      def commands
        self.class.const_get('Serverspec').const_get('Commands').const_get(RSpec.configuration.os).new
      end
    end
  end
end
