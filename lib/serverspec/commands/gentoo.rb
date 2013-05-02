module Serverspec
  module Commands
    class Gentoo < Base
      def check_enabled service
        "/sbin/rc-update show | grep '^\\s*#{service}\\s*|\\s*\\(boot\\|default\\)'"
      end

      def check_installed package
        "/usr/bin/eix #{package} --installed"
      end

      def check_running service
        "/etc/init.d/#{service} status"
      end
    end
  end
end
