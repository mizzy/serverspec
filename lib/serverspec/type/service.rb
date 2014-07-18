module Serverspec
  module Type
    class Service < Base
      def enabled?(level=3)
        @runner.check_service_is_enabled(@name, level)
      end

      def installed?(name, version)
        @runner.check_service_installed(@name)
      end

      def has_start_mode?(mode)
        @runner.check_service_start_mode(@name, mode)
      end

      def running?(under)
        if under
          check_method = "check_service_is_running_under_#{under}".to_sym
          @runner.send(check_method, @name)
        else
          @runner.check_service_is_running(@name)
        end
      end

      def monitored_by?(monitor)
        check_method = "check_service_is_monitored_by_#{monitor}".to_sym
        res = @runner.send(check_method, @name)
      end

      def has_property?(property)
        @runner.check_svcprops(@name, property)
      end
    end
  end
end
