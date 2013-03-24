module Serverspec
  module Commands
    class Debian < Base
      def check_enabled service
        "ls /etc/rc3.d/ 2> /dev/null | grep #{service}"
      end

      def check_installed package
        "dpkg -s #{package} 2> /dev/null"
      end
    end
  end
end
