module Serverspec
  module Commands
    class Solaris11 < Solaris
      # Please implement Solaris 11 specific commands

      def check_file_md5checksum(file, expected)
        "md5sum #{escape(file)} | grep -iw -- #{escape(expected)}"
      end

    end
  end
end
