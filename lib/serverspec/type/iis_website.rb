module Serverspec
  module Type
    class IisWebsite < Base
      def enabled?()
        backend.check_iis_website_enabled(@name)
      end

      def installed?(provider, version)
        backend.check_iis_website_installed(@name)
      end

      def running?()
          backend.check_iis_website_running(@name)
      end

      def in_app_pool?(app_pool)
        backend.check_iis_app_pool(@name, app_pool)
      end

      def path(path)
          backend.check_iis_website_path(@name, path)
      end
  

    end
  end
end
