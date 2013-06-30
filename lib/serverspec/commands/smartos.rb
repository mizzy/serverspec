module Serverspec
  module Commands
    class SmartOS < Serverspec::Commands::Solaris
      def check_installed(package, version=nil)
        cmd = "/opt/local/bin/pkgin 2> /dev/null"
        if version
          cmd = "#{cmd} | grep -qw -- #{escape(version)}"
        end
        cmd
      end
    end
  end
end
