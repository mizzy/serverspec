module Serverspec
  module Commands
    class Solaris10 < Solaris
      # Please implement Solaris 10 specific commands
      def check_mode(file, mode)
        regexp = mode.to_s.split(//).map do |i|
          case i
          when '7'
            'rwx'
          when '6'
            'rw-'
          when '5'
            'r-x'
          when '4'
            'r--'
          when '3'
            '-wx'
          when '2'
            '-w-'
          when '1'
            '--x'
          when '0'
            '--'
          end
        end.join('')

        "ls -l #{escape(file)} | grep -w -- #{escape(regexp)}"
      end

      def check_owner(file, owner)
        regexp = "^#{owner}$"
        "ls -l #{escape(file)} | awk '{print $3}' | grep -- #{escape(regexp)}"
      end

      def check_group(group)
        "getent group | grep -w -- #{escape(group)}"
      end

      def check_grouped(file, group)
        regexp = "^#{group}$"
        "ls -l #{escape(file)} | awk '{print $4}' | grep -- #{escape(regexp)}"
      end

      def check_link(link, target)
        regexp = "^#{target}$"
        "ls -l #{escape(link)} | awk '{print $11}' | grep -- #{escape(regexp)}"
      end

      def get_mode(file)
        "perl -e 'printf \"%o\", (stat shift)[2]&07777' #{escape(file)}"
      end

      def check_file_contain(file, expected_pattern)
        "grep -- #{escape(expected_pattern)} #{escape(file)}"
      end

      def check_reachable(host, port, proto, timeout)
        if port.nil?
          "ping -n #{escape(host)} #{escape(timeout)}"
        elsif proto == 'tcp'
          "echo 'quit' | mconnect -p #{escape(port)} #{escape(host)} > /dev/null 2>&1"
        else
          raise NotImplementedError.new
        end
      end

      def check_installed(package, version=nil)
        cmd = "pkginfo -q  #{escape(package)}"
        if version
          cmd = "#{cmd} | grep -- #{escape(version)}"
        end
        cmd
      end

      def check_file_md5checksum(file, expected)
        "digest -a md5 -v #{escape(file)} | grep -iw -- #{escape(expected)}"
      end

      def check_belonging_group(user, group)
        "id -ap #{escape(user)} | grep -- #{escape(group)}"
      end

      def check_authorized_key(user, key)
        key.sub!(/\s+\S*$/, '') if key.match(/^\S+\s+\S+\s+\S*$/)
        "/usr/xpg4/bin/grep -F -- #{escape(key)} ~#{escape(user)}/.ssh/authorized_keys"
      end

    end
  end
end
