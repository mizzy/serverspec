module Serverspec
  module Commands
    class Debian < Base
      def check_enabled service
        "ls /etc/rc3.d/ | grep #{service}"
      end

      def check_installed package
        "dpkg -s #{package}"
      end
    end
  end
end
