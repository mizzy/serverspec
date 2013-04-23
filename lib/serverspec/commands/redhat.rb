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
        "/usr/sbin/getenforce | grep 'Enforcing'"
      end
    end
  end
end
