module Serverspec
  module Type
    class Service < Base
      def enabled?
        backend.check_enabled(@name)
      end

      def running? under
        if under
          check_method = "check_running_under_#{under}".to_sym

          unless backend.respond_to?(check_method)
            raise ArgumentError.new("`be_running` matcher doesn't support #{@under}")
          end

          backend.send(check_method, @name)
        else
          backend.check_running(@name)
        end
      end

      def has_property?(property)
        backend.check_svcprops(@name, property)
      end
    end
  end
end
