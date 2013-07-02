require 'shellwords'

module Serverspec
  module Commands
    class Base
      class NotImplementedError < Exception; end

      def escape(target)
        Shellwords.shellescape(target.to_s())
      end

      def check_enabled(service, level=3)
        raise NotImplementedError.new
      end

      def check_yumrepo(repository)
        raise NotImplementedError.new
      end

      def check_yumrepo_enabled(repository)
        raise NotImplementedError.new
      end

      def check_mounted(path)
        regexp = "on #{path}"
        "mount | grep -w -- #{escape(regexp)}"
      end

      def check_routing_table(destination)
        "ip route | grep -E '^#{destination} |^default '"
      end

      def check_reachable(host, port, proto, timeout)
        if port.nil?
          "ping -n #{escape(host)} -w #{escape(timeout)} -c 2"
        else
          "nc -vvvvz#{escape(proto[0].chr)} #{escape(host)} #{escape(port)} -w #{escape(timeout)}"
        end
      end

      def check_resolvable(name, type)
        if type == "dns"
          "nslookup -timeout=1 #{escape(name)}"
        elsif type == "hosts"
          "grep -w -- #{escape(name)} /etc/hosts"
        else
          "getent hosts #{escape(name)}"
        end
      end

      def check_file(file)
        "test -f #{escape(file)}"
      end

      def check_socket(file)
        "test -S #{escape(file)}"
      end

      def check_directory(directory)
        "test -d #{escape(directory)}"
      end

      def check_user(user)
        "id #{escape(user)}"
      end

      def check_group(group)
        "getent group | grep -wq -- #{escape(group)}"
      end

      def check_installed(package, version=nil)
        raise NotImplementedError.new
      end

      def check_listening(port)
        regexp = ":#{port} "
        "netstat -tunl | grep -- #{escape(regexp)}"
      end

      def check_running(service)
        "service #{escape(service)} status"
      end

      def check_running_under_supervisor(service)
        "supervisorctl status #{escape(service)}"
      end

      def check_running_under_upstart(service)
        "initctl status #{escape(service)}"
      end

      def check_monitored_by_monit(service)
        "monit status"
      end

      def check_process(process)
        "ps aux | grep -w -- #{escape(process)} | grep -qv grep"
      end

      def check_file_contain(file, expected_pattern)
        "grep -q -- #{escape(expected_pattern)} #{escape(file)}"
      end

      def check_file_md5checksum(file, expected)
        "md5sum #{escape(file)} | grep -iw -- ^#{escape(expected)}"
      end

      def check_file_contain_within(file, expected_pattern, from=nil, to=nil)
        from ||= '1'
        to ||= '$'
        checker = check_file_contain("-", expected_pattern)
        "sed -n #{escape(from)},#{escape(to)}p #{escape(file)} | #{checker}"
      end

      def check_mode(file, mode)
        regexp = "^#{mode}$"
        "stat -c %a #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def check_owner(file, owner)
        regexp = "^#{owner}$"
        "stat -c %U #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def check_grouped(file, group)
        regexp = "^#{group}$"
        "stat -c %G #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def check_cron_entry(user, entry)
        entry_escaped = entry.gsub(/\*/, '\\*')
        if user.nil?
          "crontab -l | grep -- #{escape(entry_escaped)}"
        else
          "crontab -u #{escape(user)} -l | grep -- #{escape(entry_escaped)}"
        end
      end

      def check_link(link, target)
        "stat -c %N #{escape(link)} | grep -- #{escape(target)}"
      end

      def check_installed_by_gem(name, version=nil)
        cmd = "gem list --local | grep -w -- ^#{escape(name)}"
        if ! version.nil?
          cmd = "#{cmd} | grep -w -- #{escape(version)}"
        end
        cmd
      end

      def check_installed_by_npm(name, version=nil)
        cmd = "npm ls #{escape(name)} -g"
        cmd = "#{cmd} | grep -w -- #{escape(version)}" unless version.nil?
        cmd
      end

      def check_installed_by_pecl(name, version=nil)
        cmd = "pecl list | grep -w -- ^#{escape(name)}"
        if ! version.nil?
          cmd = "#{cmd} | grep -w -- #{escape(version)}"
        end
        cmd
      end

      def check_belonging_group(user, group)
        "id #{escape(user)} | awk '{print $3}' | grep -- #{escape(group)}"
      end

      def check_gid(group, gid)
        regexp = "^#{group}"
        "getent group | grep -w -- #{escape(regexp)} | cut -f 3 -d ':' | grep -w -- #{escape(gid)}"
      end

      def check_uid(user, uid)
        regexp = "^uid=#{uid}("
        "id #{escape(user)} | grep -- #{escape(regexp)}"
      end

      def check_login_shell(user, path_to_shell)
        "getent passwd #{escape(user)} | cut -f 7 -d ':' | grep -w -- #{escape(path_to_shell)}"
      end

      def check_home_directory(user, path_to_home)
        "getent passwd #{escape(user)} | cut -f 6 -d ':' | grep -w -- #{escape(path_to_home)}"
      end

      def check_authorized_key(user, key)
        key.sub!(/\s+\S*$/, '') if key.match(/^\S+\s+\S+\s+\S*$/)
        "grep -w -- #{escape(key)} ~#{escape(user)}/.ssh/authorized_keys"
      end

      def check_iptables_rule(rule, table=nil, chain=nil)
        raise NotImplementedError.new
      end

      def check_zfs(zfs, property=nil, value=nil)
        raise NotImplementedError.new
      end

      def get_mode(file)
        "stat -c %a #{escape(file)}"
      end

      def check_ipfilter_rule(rule)
        raise NotImplementedError.new
      end

      def check_ipnat_rule(rule)
        raise NotImplementedError.new
      end

      def check_svcprop(svc, property, value)
        raise NotImplementedError.new
      end

      def check_svcprops(svc, property)
        raise NotImplementedError.new
      end

      def check_selinux(mode)
        raise NotImplementedError.new
      end

      def check_access_by_user(file, user, access)
        raise NotImplementedError.new
      end

      def check_kernel_module_loaded(name)
        raise NotImplementedError.new
      end
    end
  end
end
