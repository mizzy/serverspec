require 'shellwords'

module Serverspec
  module Commands
    class Aix < Base
      class NotImplementedError < Exception; end

      def check_access_by_user(file, user, access)
        "su -s sh -c \"test -#{access} #{file}\" #{user}"
      end

      def check_enabled(service,level=nil)
         "lssrc -s #{escape(service)} | grep active"
      end
       
      def check_running(service)
         "ps -ef | grep -v grep | grep #{escape(service)}"
      end

      def check_installed(package,version=nil)
        "lslpp -L #{escape(package)}"
      end

      def check_listening(port)
        regexp = "*.#{port} "
        "netstat -an -f inet | awk '{print $4}' | grep  -- #{regexp}"
        #"netstat -an -f inet | awk '{print $4}' | grep  -- #{escape(regexp)}"
      end

      def check_belonging_group(user, group)
        "lsuser -a groups #{escape(user)} | awk -F'=' '{print $2}'| sed -e 's/,/ /g' |grep -w  -- #{escape(group)}"
      end

      def check_gid(group, gid)
        regexp = "^#{group}"
        "cat etc/group | grep -w -- #{escape(regexp)} | cut -f 3 -d ':' | grep -w -- #{escape(gid)}"
      end

      def check_login_shell(user, path_to_shell)
        "lsuser -a shell #{escape(user)} |awk -F'=' '{print $2}' | grep -w -- #{escape(path_to_shell)}"
      end

      def check_home_directory(user, path_to_home)
        "lsuser -a home #{escape(user)} | awk -F'=' '{print $2}' | grep -w -- #{escape(path_to_home)}"
      end

    end
  end
end
