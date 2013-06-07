module Serverspec
  module Commands
    class Debian < Linux
      def check_enabled service
        "ls /etc/rc3.d/ | grep -- #{escape(service)}"
      end

      def check_installed package
        escaped_package = escape(package)
        "dpkg -s #{escaped_package} && ! dpkg -s #{escaped_package} | grep -E '^Status: .+ not-installed$'"
      end
    end
  end
end
