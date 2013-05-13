require 'shellwords'

module Serverspec
  module Commands
    class Darwin < Base
      class NotImplementedError < Exception; end

      def check_file_md5checksum file, expected
        "openssl md5 #{escape(file)} | cut -d'=' -f2 | cut -c 2- | grep -E ^#{escape(expected)}$"
      end

      def check_access_by_user file, user, access
        "sudo -u #{user} -s /bin/test -#{access} #{file}"
      end
    end
  end
end
