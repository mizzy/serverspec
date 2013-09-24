module Serverspec
  module Commands
    class FreeBSD < Base
      def check_enabled(service, level=3)
        "service -e | grep -- #{escape(service)}"
      end

      def check_installed(package, version=nil)
        "pkg_version -X -s #{escape(package)}"
      end

      def check_listening(port)
        regexp = ":#{port} "
        "sockstat -46l -p #{port} | grep -- #{escape(regexp)}"
      end
    end
  end
end
