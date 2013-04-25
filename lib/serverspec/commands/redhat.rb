module Serverspec
  module Commands
    class RedHat < Base
      def check_enabled service
        "chkconfig --list #{service} | grep 3:on"
      end

      def check_installed package
        "rpm -q #{package}"
      end

      def check_enforcing
        "/usr/sbin/getenforce | grep -i 'enforcing'"
      end

      def check_permissive
        "/usr/sbin/getenforce | grep -i 'permissive'"
      end

      def check_disabled
        "/usr/sbin/getenforce | grep -i 'disabled'"
      end
    end
  end
end
