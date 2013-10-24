require 'shellwords'

module Serverspec
  module Commands
    class Linux < Base
      def check_access_by_user(file, user, access)
        "su -s /bin/sh -c \"test -#{access} #{file}\" #{user}"
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
        cmd =  ""
        cmd += "test ! -f /etc/selinux/config || (" if mode == "disabled"
        cmd += "getenforce | grep -i -- #{escape(mode)} "
        cmd += "&& grep -i -- ^SELINUX=#{escape(mode)}$ /etc/selinux/config"
        cmd += ")" if mode == "disabled"
        cmd
      end

      def check_kernel_module_loaded(name)
        "lsmod | grep ^#{name}"
      end

      def get_interface_speed_of(name)
        "ethtool #{name} | grep Speed | gawk '{print gensub(/Speed: ([0-9]+)Mb\\\/s/,\"\\\\1\",\"\")}'"
      end

      def check_ipv4_address(interface, ip_address)
        ip_address = ip_address.dup
        if ip_address =~ /\/\d+$/
          ip_address << " "
        else
          ip_address << "/"
        end
        ip_address.gsub!(".", "\\.")
        "ip addr show #{interface} | grep 'inet #{ip_address}'"
      end
      
      def check_zfs(zfs, property=nil)
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

      def check_container(container)
        "lxc-ls -1 | grep -w #{escape(container)}"
      end

      def check_container_running(container)
        "lxc-info -n #{escape(container)} -t RUNNING"
      end

    end
  end
end
