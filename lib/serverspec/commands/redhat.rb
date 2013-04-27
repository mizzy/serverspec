module Serverspec
  module Commands
    class RedHat < Base
      def check_enabled service
        "chkconfig --list #{service} | grep 3:on"
      end

      def check_installed package
        "rpm -q #{package}"
      end

      def check_selinux mode
        "/usr/sbin/getenforce | grep -i '#{mode}'"
      end
    end
  end
end
