module Serverspec
  module Commands
    class Solaris10 < Solaris
      # Please implement Solaris 10 specific commands

      # reference: http://perldoc.perl.org/functions/stat.html
      def check_mode(file, mode)
        regexp = "^#{mode}$"
        "perl -e 'printf \"%o\", (stat shift)[2]&07777' #{escape(file)}  | grep -- #{escape(regexp)}"
      end

      # reference: http://perldoc.perl.org/functions/stat.html
      #            http://www.tutorialspoint.com/perl/perl_getpwuid.htm
      def check_owner(file, owner)
        regexp = "^#{owner}$"
        "perl -e 'printf \"%s\", getpwuid((stat(\"#{escape(file)}\"))[4])' | grep -- #{escape(regexp)}"
      end

      def check_group(group)
        "getent group | grep -w -- #{escape(group)}"
      end

      # reference: http://perldoc.perl.org/functions/stat.html
      #            http://www.tutorialspoint.com/perl/perl_getgrgid.htm
      def check_grouped(file, group)
        regexp = "^#{group}$"
        "perl -e 'printf \"%s\", getgrgid((stat(\"#{escape(file)}\"))[5])'  | grep -- #{escape(regexp)}"
      end

      # reference: http://www.tutorialspoint.com/perl/perl_readlink.htm
      def check_link(link, target)
        regexp = "^#{target}$"
        "perl -e 'printf \"%s\", readlink(\"#{escape(link)}\")' | grep -- #{escape(regexp)}"
      end

      # reference: http://perldoc.perl.org/functions/stat.html
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
        "grep -- #{escape(key)} ~#{escape(user)}/.ssh/authorized_keys"
      end

    end
  end
end
