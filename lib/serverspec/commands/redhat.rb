module Serverspec
  module Commands
    class RedHat < Linux
      def check_access_by_user file, user, access
        # Redhat-specific
        "runuser -s sh -c \"test -#{access} #{file}\" #{user}"
      end

      def check_enabled service
        "chkconfig --list #{escape(service)} | grep 3:on"
      end

      def check_installed package
        "rpm -q #{escape(package)}"
      end
    end
  end
end
