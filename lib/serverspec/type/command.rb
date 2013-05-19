module Serverspec
  module Type
    class Command < Base
      def return_stdout?(content)
        ret = backend.run_command(@name)
        if content.instance_of?(Regexp)
          ret[:stdout] =~ content
        else
          ret[:stdout].strip == content
        end
      end

      def return_stderr?(content)
        ret = backend.run_command(@name)
        # In ssh access with pty, stderr is merged to stdout
        # See http://stackoverflow.com/questions/7937651/receiving-extended-data-with-ssh-using-twisted-conch-as-client
        # So I use stdout instead of stderr
        if content.instance_of?(Regexp)
          ret[:stdout] =~ content
        else
          ret[:stdout].strip == content
        end
      end

      def return_exit_status?(status)
        ret = backend.run_command(@name)
        ret[:exit_status].to_i == status
      end
    end
  end
end
