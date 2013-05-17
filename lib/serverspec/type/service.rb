module Serverspec
  module Type
    class Service < Base
      def enabled?
        backend.check_enabled(nil, @name)
      end

      def running? under
        if under
          check_method = "check_running_under_#{under}".to_sym

          unless backend.respond_to?(check_method)
            raise ArgumentError.new("`be_running` matcher doesn't support #{@under}")
          end

          backend.send(check_method, nil, @name)
        else
          backend.check_running(nil, @name)
        end
      end
    end
  end
end
