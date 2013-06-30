module Serverspec
  module Commands
    class SmartOS < Serverspec::Commands::Solaris
      def check_installed(package, version=nil)
        cmd = "/opt/local/bin/pkgin list 2> /dev/null | grep -qw ^#{escape(package)}"
        if version
          cmd = "#{cmd}-#{escape(version)}"
        end
        cmd
      end
    end
  end
end
