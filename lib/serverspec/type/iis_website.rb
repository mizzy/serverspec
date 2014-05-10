module Serverspec
  module Type
    class IisWebsite < Base

      def exists?()
        @runner.check_iis_website_installed(@name)
      end

      def enabled?()
        @runner.check_iis_website_enabled(@name)
      end

      def running?()
        @runner.check_iis_website_running(@name)
      end

      def in_app_pool?(app_pool)
        @runner.check_iis_website_app_pool(@name, app_pool)
      end

      def has_physical_path?(path)
        @runner.check_iis_website_path(@name, path)
      end

      def to_s
        %Q[IIS Website "#{@name}"]
      end
    end
  end
end
