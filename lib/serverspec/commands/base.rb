module Serverspec
  module Commands
    class Base
      class NotImplementedError < Exception; end

      def check_enabled service
        raise NotImplementedError.new
      end

      def check_file file
        "test -f #{file} 2> /dev/null"
      end

      def check_installed package
        raise NotImplementedError.new
      end

      def check_listening port
        "netstat -tnl 2> /dev/null | grep ':#{port} '"
      end

      def check_running service
        raise NotImplementedError.new
      end

      def check_file_contain file, expected_pattern
        "\"grep -q '#{expected_pattern}' #{file} \" 2> /dev/null"
      end
    end
  end
end
