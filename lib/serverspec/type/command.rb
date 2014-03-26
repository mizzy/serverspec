module Serverspec
  module Type
    class Command < Base
      attr_accessor :result

      def return_stdout?(content)
        ret = backend.run_command(@name)
        if content.instance_of?(Regexp)
          ret.stdout =~ content
        else
          ret.stdout.strip == content
        end
      end

      def return_stderr?(content)
        ret = backend.run_command(@name)
        if content.instance_of?(Regexp)
          ret.stderr =~ content
        else
          ret.stderr.strip == content
        end
      end

      def return_exit_status?(status)
        ret = backend.run_command(@name)
        ret.exit_status.to_i == status
      end

      def stdout
        if @result.nil?
          @result = backend.run_command(@name).stdout
        end
        @result
      end

      def stderr
        if @result.nil?
          @result = backend.run_command(@name).stderr
        end
        @result
      end
    end
  end
end
