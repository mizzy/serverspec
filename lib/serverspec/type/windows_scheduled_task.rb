module Serverspec
  module Type
    class WindowsScheduledTask < Base
      def exists?
        @runner.check_scheduled_task(@name)
      end
    end
  end
end
