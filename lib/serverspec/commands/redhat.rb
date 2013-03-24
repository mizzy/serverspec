module Serverspec
  module Commands
    class RedHat < Base
      def check_enabled service
        "chkconfig --list #{service} 2> /dev/null | grep 3:on"
      end

      def check_installed package
        "rpm -q #{package} 2> /dev/null"
      end
    end
  end
end
