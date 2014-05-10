module Serverspec
  module Type
    class Command < Base
      def return_stdout?(content)
        if content.instance_of?(Regexp)
          stdout =~ content
        else
          stdout.strip == content
        end
      end

      def return_stderr?(content)
        if content.instance_of?(Regexp)
          stderr =~ content
        else
          stderr.strip == content
        end
      end

      def return_exit_status?(status)
        exit_status == status
      end

      def stdout
        command_result.stdout
      end

      def stderr
        command_result.stderr
      end

      def exit_status
        command_result.exit_status.to_i
      end

      private

      def command_result()
	@command_result ||= backend.run_command(@name)
      end
    end
  end
end
