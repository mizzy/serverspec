module Serverspec
  module Type
    class WindowsScheduledTask < Base
      def exists?
        @runner.check_scheduled_task_exists(@name)
      end
    end
  end
end
