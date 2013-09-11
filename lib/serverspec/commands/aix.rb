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
        "groups #{escape(user)} | awk -F':' '{print $2}' | grep -- #{escape(group)}"
      end


    end
  end
end
