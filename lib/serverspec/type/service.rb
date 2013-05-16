module Serverspec
  module Type
    class Service
      def initialize name
        @name = name
      end
      def enabled?
        backend.check_enabled(nil, @name)
      end
    end
  end
end
