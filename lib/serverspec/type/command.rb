module Serverspec
  module Type
    class Command < Base
      def self.match?(actual, expected)
        expected.is_a?(Regexp) ? actual =~ expected : actual.strip == expected
      end

      # args can be strings (full, exact match) or regex
      # In order to return true, all args must match at least one line
      def self.match_multiline?(actual, *args)
        raise "String required (#{actual.class})" unless actual.is_a?(String)
        lines = actual.split("\n").map { |l| l.strip }
        args.each { |a|
          found = false
          lines.each { |l| break if found = self.match?(l, a) }
          return false unless found
        }
        true
      end

      def return_stdout?(*args)
        self.class.match_multiline?(backend.run_command(@name)[:stdout], *args)
      end

      # In ssh access with pty, stderr is merged to stdout
      # See http://stackoverflow.com/questions/7937651/receiving-extended-data-with-ssh-using-twisted-conch-as-client
      # So I use stdout instead of stderr
      alias_method :return_stderr?, :return_stdout?

      def return_exit_status?(status)
        backend.run_command(@name)[:exit_status].to_i == status.to_i
      end
    end
  end
end
