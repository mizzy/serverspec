module Serverspec::Type
  class IisWebsite < Base

    def exists?()
      @runner.check_iis_website_is_installed(@name)
    end

    def enabled?()
      @runner.check_iis_website_is_enabled(@name)
    end

    def running?()
      @runner.check_iis_website_is_running(@name)
    end

    def in_app_pool?(app_pool)
      @runner.check_iis_website_is_in_app_pool(@name, app_pool)
    end

    def has_physical_path?(path)
      @runner.check_iis_website_has_physical_path(@name, path)
    end

    def has_site_bindings?(port, protocol, ipaddress, host_header)
      @runner.check_iis_website_has_site_bindings(@name, port, protocol, ipaddress, host_header)
    end
      
    def has_virtual_dir?(vdir, path)
      @runner.check_iis_website_has_virtual_dir(@name, vdir, path)
    end
      
    def has_site_application?(app, pool, physical_path)
      @runner.check_iis_website_has_site_application(@name, app, pool, physical_path)
    end

    def to_s
      %Q[IIS Website "#{@name}"]
    end
  end
end
