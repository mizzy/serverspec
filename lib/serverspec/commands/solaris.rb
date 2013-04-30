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

      def check_zfs zfs, property=nil
        if property.nil?
          "/sbin/zfs list -H #{zfs}"
        else
          commands = []
          property.sort.each do |key, value|
            commands << "/sbin/zfs list -H -o #{key} #{zfs} | grep ^#{value}$"
          end
          commands.join(' && ')
        end
      end

      def check_ipfilter_rule rule
        "/sbin/ipfstat -io 2> /dev/null | grep '#{rule}'"
      end

      def check_ipnat_rule rule
        "/sbin/ipnat -l 2> /dev/null | grep '^#{rule}$'"
      end

      def check_svcprop svc, property, value
        "svcprop -p #{property} #{svc} | grep ^#{value}$"
      end

      def check_svcprops svc, property
        commands = []
        property.sort.each do |key, value|
          commands << "svcprop -p #{key} #{svc} | grep ^#{value}$"
        end
        commands.join(' && ')
      end

      def check_file_contain_within file, expected_pattern, from=nil, to=nil
        from ||= '1'
        to ||= '$'
        checker = check_file_contain("/dev/stdin", expected_pattern)
        "sed -n '#{from},#{to}p' #{file} | #{checker}"
      end

      def check_belonging_group user, group
        "id -Gn #{user} | grep #{group}"
      end
    end
  end
end
