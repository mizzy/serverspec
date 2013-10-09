module Serverspec
  module Type
    class Service < Base
      def enabled?(level=3)
        backend.check_enabled(@name, level)
      end

      def running?(under, process_name=nil)
        process_name ||= @name

        if under
          check_method = "check_running_under_#{under}".to_sym

          unless commands.respond_to?(check_method)
            raise ArgumentError.new("`be_running` matcher doesn't support #{under}")
          end

          backend.send(check_method, @name)
        else
          backend.check_running(@name, process_name)
        end
      end

      def monitored_by?(monitor)
        check_method = "check_monitored_by_#{monitor}".to_sym
        unless monitor && commands.respond_to?(check_method)
          raise ArgumentError.new("`be_monitored_by` matcher doesn't support #{monitor}")
        end

        backend.send(check_method, @name)
      end

      def has_property?(property)
        backend.check_svcprops(@name, property)
      end
    end
  end
end
