module Serverspec
  module Type
    class IisWebsite < Base

      def exists?()
        backend.check_iis_website_installed(@name)
      end

      def enabled?()
        backend.check_iis_website_enabled(@name)
      end

      def running?()
        backend.check_iis_website_running(@name)
      end

      def in_app_pool?(app_pool)
        backend.check_iis_website_app_pool(@name, app_pool)
      end

      def has_physical_path?(path)
        backend.check_iis_website_path(@name, path)
      end
    
      def has_site_bindings?(bindings)
        backend.check_iis_website_binding(@name, bindings)
      end

      def to_s
        %Q[IIS Website "#{@name}"]
      end
    end
  end
end
