module Serverspec
  module Commands
    class RedHat < Base
      def check_enabled service
        "chkconfig --list #{escape(service)} | grep 3:on"
      end

      def check_installed package
        "rpm -q #{escape(package)}"
      end
    end
  end
end
