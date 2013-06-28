require 'shellwords'

module Serverspec
  module Commands
    class Linux < Base
      def check_access_by_user(file, user, access)
        "su -c \"test -#{access} #{file}\" #{user}"
      end

      def check_iptables_rule(rule, table=nil, chain=nil)
        cmd = "iptables"
        cmd += " -t #{escape(table)}" if table
        cmd += " -S"
        cmd += " #{escape(chain)}" if chain
        cmd += " | grep -- #{escape(rule)}"
        cmd
      end

      def check_selinux(mode)
        "getenforce | grep -i -- #{escape(mode)} && grep -i -- ^SELINUX=#{escape(mode)}$ /etc/selinux/config"
      end

      def check_kernel_module_loaded(name)
        "lsmod | grep ^#{name}"
      end

      def get_interface_speed_of(name)
        "ethtool #{name} | grep Speed | gawk '{print gensub(/Speed: ([0-9]+)Mb\\\/s/,\"\\\\1\",\"\")}'"
      end
    end
  end
end
