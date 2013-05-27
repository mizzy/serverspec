module Serverspec
  module Commands
    class Solaris < Base
      def check_enabled service
        "svcs -l #{escape(service)} 2> /dev/null | grep 'enabled      true'"
      end

      def check_installed package
        "pkg list -H #{escape(package)} 2> /dev/null"
      end

      def check_listening port
        regexp = "\.#{port} "
        "netstat -an 2> /dev/null | egrep 'LISTEN|Idle' | grep -- #{escape(regexp)}"
      end

      def check_running service
        "svcs -l #{escape(service)} status 2> /dev/null |grep 'state        online'"
      end

      def check_cron_entry user, entry
        entry_escaped = entry.gsub(/\*/, '\\*')
        if user.nil?
          "crontab -l | grep -- #{escape(entry_escaped)}"
        else
          "crontab -l #{escape(user)} | grep -- #{escape(entry_escaped)}"
        end
      end

      def check_zfs zfs, property=nil
        if property.nil?
          "zfs list -H #{escape(zfs)}"
        else
          commands = []
          property.sort.each do |key, value|
            regexp = "^#{value}$"
            commands << "zfs list -H -o #{escape(key)} #{escape(zfs)} | grep -- #{escape(regexp)}"
          end
          commands.join(' && ')
        end
      end

      def check_ipfilter_rule rule
        "ipfstat -io 2> /dev/null | grep -- #{escape(rule)}"
      end

      def check_ipnat_rule rule
        regexp = "^#{rule}$"
        "ipnat -l 2> /dev/null | grep -- #{escape(regexp)}"
      end

      def check_svcprop svc, property, value
        regexp = "^#{value}$"
        "svcprop -p #{escape(property)} #{escape(svc)} | grep -- #{escape(regexp)}"
      end

      def check_svcprops svc, property
        commands = []
        property.sort.each do |key, value|
          regexp = "^#{value}$"
          commands << "svcprop -p #{escape(key)} #{escape(svc)} | grep -- #{escape(regexp)}"
        end
        commands.join(' && ')
      end

      def check_file_contain_within file, expected_pattern, from=nil, to=nil
        from ||= '1'
        to ||= '$'
        checker = check_file_contain("/dev/stdin", expected_pattern)
        "sed -n #{escape(from)},#{escape(to)}p #{escape(file)} | #{checker}"
      end

      def check_belonging_group user, group
        "id -Gn #{escape(user)} | grep -- #{escape(group)}"
      end

      def check_gid group, gid
        regexp = "^#{group}:"
        "getent group | grep -- #{escape(regexp)} | cut -f 3 -d ':' | grep -w -- #{escape(gid)}"
      end

      def check_home_directory user, path_to_home
        "getent passwd #{escape(user)} | cut -f 6 -d ':' | grep -w -- #{escape(path_to_home)}"
      end

      def check_login_shell user, path_to_shell
        "getent passwd #{escape(user)} | cut -f 7 -d ':' | grep -w -- #{escape(path_to_shell)}"
      end

      def check_access_by_user file, user, access
        # http://docs.oracle.com/cd/E23823_01/html/816-5166/su-1m.html
        ## No need for login shell as it seems that behavior as superuser is favorable for us, but needs
        ## to be better tested under real solaris env
        "su #{user} -c \"test -#{access} #{file}\""
      end
    end
  end
end
