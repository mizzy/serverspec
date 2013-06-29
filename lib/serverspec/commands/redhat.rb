module Serverspec
  module Commands
    class RedHat < Linux
      def check_access_by_user(file, user, access)
        # Redhat-specific
        "runuser -c \"test -#{access} #{file}\" #{user}"
      end

      def check_enabled(service, level=3)
        "chkconfig --list #{escape(service)} | grep #{level}:on"
      end

      def check_yumrepo(repository)
        "yum repolist all -C | grep ^#{escape(repository)}"
      end

      def check_yumrepo_enabled(repository)
        "yum repolist all -C | grep ^#{escape(repository)} | grep enabled"
      end

      def check_installed(package,version=nil)
        cmd = "rpm -q #{escape(package)}"
        if ! version.nil?
          cmd = "#{cmd} | grep -w -- #{escape(version)}"
        end
        cmd
      end
    end
  end
end
