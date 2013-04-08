module Serverspec
  module Commands
    class Solaris < Base
      def check_enabled service
        "svcs -l #{service} 2> /dev/null | grep 'enabled      true'"
      end

      def check_installed package
        "pkg list -H #{package} 2> /dev/null"
      end

      def check_listening port
        "netstat -an 2> /dev/null | egrep 'LISTEN|Idle' | grep '\.#{port} '"
      end

      def check_running service
        "svcs -l #{service} status 2> /dev/null |grep 'state        online'"
      end

      def check_cron_entry user, entry
        entry_escaped = entry.gsub(/\*/, '\\*')
        "crontab -l #{user} | grep '#{entry_escaped}'"
      end

      def check_zfs zfs, property=nil, value=nil
        if (value || property).nil?
          "/sbin/zfs list -H #{zfs} 2> /dev/null"
        else
          "/sbin/zfs get -H  #{property} #{zfs} 2> /dev/null | grep #{value}"
        end
      end
    end
  end
end
