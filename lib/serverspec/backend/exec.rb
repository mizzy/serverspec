module Serverspec
  module Backend
    class Exec
      def initialize(commands)
        @commands ||= commands
      end

      def commands
        @commands
      end

      def do_check(cmd, opts={})
        stdout = `#{cmd} 2>&1`
        # In ruby 1.9, it is possible to use Open3.capture3, but not in 1.8
        #stdout, stderr, status = Open3.capture3(cmd)
        { :stdout => stdout, :stderr => nil,
          :exit_code => $?, :exit_signal => nil }
      end

      def check_zero(cmd, *args)
        ret = do_check(commands.send(cmd, *args))
        ret[:exit_code] == 0
      end

      def check_directory(directory)
        check_zero(:check_directory, directory)
      end

      def check_enabled(service)
        check_zero(:check_enabled, service)
      end

      def check_file(file)
        check_zero(:check_file, file)
      end

      def check_group(group)
        check_zero(:check_group, group)
      end

      def check_grouped(file, group)
        check_zero(:check_grouped, file, group)
      end

      def check_installed(package)
        check_zero(:check_installed, package)
      end

      def check_installed_by_gem(package, version)
        ret = do_check(commands.check_installed_by_gem(package))
        res = ret[:exit_code] == 0
        if res && version
          res = false if not ret[:stdout].match(/\(#{version}\)/)
        end
        res
      end

      def check_link(link, target)
        check_zero(:check_link, link, target)
      end

      def check_listening(port)
        check_zero(:check_listening, port)
      end

      def check_mode(file, mode)
        check_zero(:check_mode, file, mode)
      end

      def check_owner(file, owner)
        check_zero(:check_owner, file, owner)
      end

      def check_running(process)
        ret = do_check(commands.check_running(process))
        if ret[:exit_code] == 1 || ret[:stdout] =~ /stopped/
          ret = do_check(commands.check_process(process))
        end
        ret[:exit_code] == 0
      end

      def check_user(user)
        check_zero(:check_user, user)
      end

      def check_belonging_group(user, group)
        check_zero(:check_belonging_group, user, group)
      end

      def check_cron_entry(user, entry)
        check_zero(:check_cron_entry, user, entry)
      end

      def check_iptables_rule(rule, table, chain)
        check_zero(:check_iptables_rule, rule, table, chain)
      end

      def check_zfs(zfs, property)
        check_zero(:check_zfs, zfs, property)
      end
    end
  end
end
