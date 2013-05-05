module Serverspec
  module Commands
    class Gentoo < Base
      def check_enabled service
        regexp = "^\\s*#{service}\\s*|\\s*\\(boot\\|default\\)"
        "/sbin/rc-update show | grep -- #{escape(regexp)}"
      end

      def check_installed package
        "/usr/bin/eix #{escape(package)} --installed"
      end

      def check_running service
        "/etc/init.d/#{escape(service)} status"
      end
    end
  end
end
