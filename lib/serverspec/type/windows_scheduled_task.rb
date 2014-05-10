module Serverspec
  module Type
    class WindowsScheduledTask < Base
      def exists?
        backend.check_scheduled_task(@name)
      end
    end
  end
end
