require 'shellwords'

module Serverspec
  module Commands
    class Darwin < Base
      def check_file_md5checksum(file, expected)
        "openssl md5 #{escape(file)} | cut -d'=' -f2 | cut -c 2- | grep -E ^#{escape(expected)}$"
      end

      def check_mode(file, mode)
        regexp = "^#{mode}$"
        "stat -f%Lp #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def check_owner(file, owner)
        regexp = "^#{owner}$"
        "stat -f %Su #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def check_grouped(file, group)
        regexp = "^#{group}$"
        "stat -f %Sg #{escape(file)} | grep -- #{escape(regexp)}"
      end

      def get_mode(file)
        "stat -f%Lp #{escape(file)}"
      end

      def check_access_by_user(file, user, access)
        "sudo -u #{user} -s /bin/test -#{access} #{file}"
      end
    end
  end
end
