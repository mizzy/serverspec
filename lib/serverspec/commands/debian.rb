module Serverspec
  module Commands
    class Debian < Linux
      def check_enabled(service, level=3)
        # Until everything uses Upstart, this needs an OR.
        "ls /etc/rc#{level}.d/ | grep -- #{escape(service)} || grep 'start on' /etc/init/#{escape(service)}.conf"      
      end

      def check_installed(package, version=nil)
        escaped_package = escape(package)
        "dpkg -s #{escaped_package} && ! dpkg -s #{escaped_package} | grep -E '^Status: .+ not-installed$'"
      end

      def check_running(service)
        # This is compatible with Debian >Jaunty and Ubuntu derivatives
        "service #{escape(service)} status | grep 'running'"
      end
    end
  end
end
