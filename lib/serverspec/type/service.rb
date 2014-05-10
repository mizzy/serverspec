module Serverspec
  module Type
    class Service < Base
      def enabled?(level=3)
        @runner.check_enabled(@name, level)
      end

      def installed?(name, version)
        @runner.check_service_installed(@name)
      end

      def has_start_mode?(mode)
        @runner.check_service_start_mode(@name, mode)
      end

      def running?(under)
        if under
          check_method = "check_running_under_#{under}".to_sym

          unless commands.respond_to?(check_method)
            raise ArgumentError.new("`be_running` matcher doesn't support #{under}")
          end

          @runner.send(check_method, @name)
        else
          @runner.check_running(@name)
        end
      end

      def monitored_by?(monitor)
        check_method = "check_monitored_by_#{monitor}".to_sym
        unless monitor && commands.respond_to?(check_method)
          raise ArgumentError.new("`be_monitored_by` matcher doesn't support #{monitor}")
        end
        res = @runner.send(check_method, @name)
      end

      def has_property?(property)
        @runner.check_svcprops(@name, property)
      end
    end
  end
end
