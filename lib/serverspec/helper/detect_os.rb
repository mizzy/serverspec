module Serverspec
  module Helper
    module DetectOS
      def commands
        os = RSpec.configuration.os || 'Base'
        self.class.const_get('Serverspec').const_get('Commands').const_get(os).new
      end
    end
  end
end
