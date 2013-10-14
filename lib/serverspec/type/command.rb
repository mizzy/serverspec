module Serverspec
  module Type
    class Command < Base
      # args can be strings (full, exact match) or regex
      # In order to return true, all args must match at least one line
      def match_multiline?(*args)
        lines = backend.run_command(@name).fetch(:stdout).split("\n").map { |l|
          l.strip
        }
        args.each { |a|
          found = false
          lines.each { |l|
            break if found
            found = (a.is_a?(Regexp) ? l.match(a) : l == a)
          }
          return false unless found
        }
        true
      end

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
        ret[:exit_status] == status.to_s
      end
    end
  end
end
