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

      def check_enabled(service, level=3)
        "svcs -l #{escape(service)} 2> /dev/null | grep -wx '^enabled.*true$'"
      end

      def check_running(service)
        "svcs -l #{escape(service)} status 2> /dev/null |grep -wx '^state.*online$'"
      end
    end
  end
end
