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
    
      def has_site_bindings?(port, protocol, ipaddress, host_header)
        backend.check_iis_website_binding(@name, port, protocol, ipaddress, host_header)
      end

      def has_virtual_dir?(vdir, path)
        backend.check_iis_website_virtual_dir(@name, vdir, path)
      end
      
      def has_site_application?(app, pool, physical_path)
        backend.check_iis_website_application(@name, app, pool, physical_path)
      end

      def to_s
        %Q[IIS Website "#{@name}"]
      end
    end
  end
end
