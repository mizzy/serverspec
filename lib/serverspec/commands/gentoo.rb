module Serverspec
  module Commands
    class Gentoo < Linux
      def check_enabled(service, level=3)
        regexp = "^\\s*#{service}\\s*|\\s*\\(boot\\|default\\)"
        "rc-update show | grep -- #{escape(regexp)}"
      end

      def check_installed(package, version=nil)
        "eix #{escape(package)} --installed"
      end

      def check_running(service)
        "/etc/init.d/#{escape(service)} status"
      end
    end
  end
end
