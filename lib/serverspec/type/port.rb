module Serverspec
  module Type
    class Port < Base
      def listening?
        backend.check_listening(nil, @name)
      end
    end
  end
end
