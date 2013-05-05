module Serverspec
  module Commands
    class Debian < Base
      def check_enabled service
        "ls /etc/rc3.d/ | grep -- #{escape(service)}"
      end

      def check_installed package
        "dpkg -s #{escape(package)}"
      end
    end
  end
end
