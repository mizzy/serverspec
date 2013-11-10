module Serverspec
  module Commands
    class Plamo < Linux

      def check_enabled(service, level=3)
        # This check is not necessarily detected whether service is enabled or not
        # TODO: check rc.inet2 $SERV variable
        "test -x /etc/rc.d/init.d/#{escape(service)}"
      end

      def check_installed(package, version=nil)
        cmd = "ls /var/log/packages/#{escape(package)}"
        if version
          cmd = "#{cmd} && grep -E \"PACKAGE NAME:.+#{escape(package)}-#{escape(version)}\" /var/log/packages/#{escape(package)}"
        end
        cmd
      end

    end
  end
end
